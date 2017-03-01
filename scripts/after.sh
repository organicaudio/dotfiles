#! /usr/bin/env bash
set -eu

# defaults read com.apple.symbolichotkeys AppleSymbolicHotKeys for all sorts of things; set a few:

# Change "Move focus to next window" shortcut to ⌘<
/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:51:value:parameters:0 60" ~/Library/Preferences/com.apple.symbolichotkeys.plist
# and "Move focus to the widnow drawer" shorcut to ⌥⌘<
/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:51:value:parameters:1 50" ~/Library/Preferences/com.apple.symbolichotkeys.plist

# Bring up Chrome Extensions via ⌘E (Window → Extensions)
/usr/libexec/PlistBuddy -c 'Add :NSUserKeyEquivalents:Extensions string @$e' ~/Library/Preferences/com.google.Chrome

# see also: https://github.com/acostami/my_osx/blob/master/1_osx.sh

# Set system time to HH:mm (24h format)
for format in \
  'Add :AppleICUTimeFormatStrings:1 string "HH:mm"' \
  'Add :AppleICUTimeFormatStrings:2 string "HH:mm:ss"' \
  'Add :AppleICUTimeFormatStrings:3 string "HH:mm:ss z"' \
  'Add :AppleICUTimeFormatStrings:4 string "HH:mm:ss zzzz"' ; do
  /usr/libexec/PlistBuddy -c "$format" ~/Library/Preferences/.GlobalPreferences.plist
done
