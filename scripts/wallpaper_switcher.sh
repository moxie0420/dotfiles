#!/usr/bin/env bash

WALLPAPER_PATH=/home/$USER/wallpapers

imgSelector() {
  find $WALLPAPER_PATH -type f | fzf
}

wallpaperPath="$(imgSelector)"

awww img $wallpaperPath
