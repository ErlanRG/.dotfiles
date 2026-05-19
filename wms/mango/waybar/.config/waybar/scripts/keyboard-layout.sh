#!/usr/bin/env bash

mmsg -g -k | jq -R --unbuffered --compact-output '
    split(" ") |
    {
        text: .[2],
        alt: .[2],
        tooltip: ("Keyboard layout: " + .[2]),
        class: ("layout-" + .[2])
    }
'
