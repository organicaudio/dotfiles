#! /usr/bin/env bash
# ideas borrowed from https://github.com/gtramontina/dotfiles/blob/master/scripts/after.sh
set -eu

log () {
  local fmt="» $1\n"; shift;
  tput setaf 2; printf "\n$fmt" "$@"; tput sgr0;
}

# defaults read com.apple.symbolichotkeys AppleSymbolicHotKeys for all sorts of things; set a few:

# Change "Move focus to next window" shortcut to ⌘<
/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:51:value:parameters:0 60" ~/Library/Preferences/com.apple.symbolichotkeys.plist
# and "Move focus to the window drawer" shorcut to ⌥⌘<
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

log "Installing Oh My Zsh…"
CUSTOM="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"
[ -d ~/.oh-my-zsh ] || (curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh)
mkdir -p "$CUSTOM"/themes
curl https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh -o "$CUSTOM"/themes/pure.zsh-theme
curl https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh -o "$CUSTOM"/async.zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$CUSTOM"/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions "$CUSTOM"/plugins/zsh-autosuggestions

log "Cleaning up brew…"
brew prune
brew cleanup --force -s
