#!/usr/bin/env bash

mmsg get keyboardlayout | jq --compact-output '
    if .layout == "English (US)" then "US" else "ES" end as $short |
    {
        text: $short,
        alt: $short,
        tooltip: ("Keyboard layout: " + .layout),
        class: ("layout-" + $short)
    }
'
