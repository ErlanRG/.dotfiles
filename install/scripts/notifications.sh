#!/usr/bin/env bash
#
# Browse mako's notification history, toggle Do Not Disturb, and feed the
# waybar notification module.

set -o pipefail

DND_MODE="do-not-disturb"
STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}/mako-notifications"
LAST_READ="$STATE_DIR/last-read"

ICON_IDLE="󰂚"
ICON_UNREAD="󰂞"
ICON_DND="󰂛"

# Decode the HTML entities some senders double-escape, turn <br/> into a real
# line break, then drop any remaining Pango tags.
JQ_CLEAN='
def unescape:
    gsub("&lt;"; "<") | gsub("&gt;"; ">") | gsub("&quot;"; "\"")
    | gsub("&#39;"; "\u0027") | gsub("&amp;"; "&");
def unbreak: gsub("<br\\s*/?>"; "\n");
def untag: gsub("<[^>]*>"; "");
def oneline: gsub("[\n\r\t]+"; " ") | gsub(" {2,}"; " ") | sub("^ +"; "") | sub(" +$"; "");
# Some senders (KDE Connect) escape twice, so decode until it settles.
def clean: unescape | unescape | unbreak | untag;
# One record per line: escape newlines, and never emit the field separator.
def oneshot: gsub("\r"; "") | gsub("\n"; "\\n") | gsub("\u001f"; " ");
'

dnd_active() {
    makoctl mode 2>/dev/null | grep -qx "$DND_MODE"
}

# Every notification mako has, on screen or expired, as one JSON array.
all_notifications() {
    { makoctl list -j 2>/dev/null; makoctl history -j 2>/dev/null; } | jq -s 'add // []'
}

unread_count() {
    local last_read
    last_read=$(cat "$LAST_READ" 2>/dev/null)
    [[ "$last_read" =~ ^[0-9]+$ ]] || last_read=0
    all_notifications | jq --argjson seen "$last_read" \
        '[.[].id] | map(select(. > $seen)) | unique | length'
}

mark_read() {
    mkdir -p "$STATE_DIR"
    all_notifications | jq '[.[].id] + [0] | max' >"$LAST_READ"
}

cmd_history() {
    local json count
    json=$(makoctl history -j 2>/dev/null) || json='[]'
    count=$(jq 'length' <<<"$json" 2>/dev/null) || count=0

    if [ "$count" -eq 0 ]; then
        notify-send -a "Notifications" "Notifications" "History is empty"
        return 0
    fi

    # Split on US (0x1f), not tab: tab is IFS whitespace, so an empty field
    # (app_icon is often "") would collapse and shift every later field left.
    local -a labels=() apps=() icons=() summaries=() bodies=()
    while IFS=$'\x1f' read -r label app icon summary body; do
        labels+=("$label")
        apps+=("$app")
        icons+=("$icon")
        summaries+=("$summary")
        bodies+=("$body")
    done < <(jq -r "$JQ_CLEAN"'
        .[]
        | (.app_name // "Notification") as $app
        | (.summary // "") as $summary
        | (.body // "") as $body
        | [
            ($app + " │ " + ($summary | clean | oneline)
                   + (if ($body | clean | oneline) == "" then ""
                      else " — " + ($body | clean | oneline) end)),
            $app,
            (.app_icon // ""),
            ($summary | clean),
            ($body | clean)
          ]
        | map(oneshot)
        | join("\u001f")' <<<"$json")

    local chosen
    chosen=$(printf '%s\n' "${labels[@]}" \
        | wofi --dmenu --prompt "Notifications" --width 700 --height 400) || return 0
    [ -n "$chosen" ] || return 0

    local i
    for i in "${!labels[@]}"; do
        if [ "${labels[$i]}" = "$chosen" ]; then
            notify-send -a "${apps[$i]}" \
                ${icons[$i]:+-i "${icons[$i]}"} \
                "${summaries[$i]}" "$(printf '%b' "${bodies[$i]}")"
            break
        fi
    done

    mark_read
}

cmd_dnd() {
    if dnd_active; then
        makoctl mode -r "$DND_MODE" >/dev/null
        notify-send -a "Notifications" "Do Not Disturb" "Off"
    else
        # Announce before enabling, or invisible=1 swallows the confirmation.
        notify-send -a "Notifications" "Do Not Disturb" "On"
        makoctl mode -a "$DND_MODE" >/dev/null
    fi
}

cmd_dismiss() {
    makoctl dismiss --all >/dev/null 2>&1
    mark_read
}

cmd_status() {
    local count icon class tooltip
    count=$(unread_count)
    [[ "$count" =~ ^[0-9]+$ ]] || count=0

    if dnd_active; then
        icon="$ICON_DND"
        class="dnd"
        tooltip="Do Not Disturb is on"
    elif [ "$count" -gt 0 ]; then
        icon="$ICON_UNREAD"
        class="unread"
        tooltip="$count unread notification"
        [ "$count" -eq 1 ] || tooltip="$tooltip"s
    else
        icon="$ICON_IDLE"
        class="default"
        tooltip="No new notifications"
    fi

    [ "$count" -gt 0 ] && icon="$icon $count"

    jq -nc --arg text "$icon" --arg tooltip "$tooltip" --arg class "$class" \
        '{text: $text, alt: $class, class: $class, tooltip: $tooltip}'
}

cmd_watch() {
    local current previous="" line rc
    previous=$(cmd_status)
    printf '%s\n' "$previous"

    # mako's Modes and Notifications properties emit invalidation signals, so
    # this is push-driven; the read timeout only catches our own state file.
    gdbus monitor --session \
        --dest org.freedesktop.Notifications \
        --object-path /fr/emersion/Mako 2>/dev/null \
    | while true; do
        read -r -t 2 line
        rc=$?
        # Anything above 128 is the read timing out; 1 or 2 means the stream died.
        if [ $rc -ne 0 ] && [ $rc -le 128 ]; then
            break
        fi

        current=$(cmd_status)
        if [ "$current" != "$previous" ]; then
            printf '%s\n' "$current"
            previous="$current"
        fi
    done
}

case "$1" in
    history)  cmd_history ;;
    dnd)      cmd_dnd ;;
    dismiss)  cmd_dismiss ;;
    status)   cmd_status ;;
    watch)    cmd_watch ;;
    *)
        echo "Usage: $0 {history|dnd|dismiss|status|watch}"
        exit 1
        ;;
esac
