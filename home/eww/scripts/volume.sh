#!/usr/bin/env bash
wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}' | sed 's/\.//'