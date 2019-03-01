# Installation

    curl -L http://git.io/jH9K | sh

# Manual installation

## Alacritty

Download latest release from github

## Firefox

Start to get profile directory, then about:support to check Profile dir

    mkdir -p ~/.mozilla/firefox/*.default/chrome
    ln -s ~/src/dotfiles/firefox/userChrome.css ~/.mozilla/firefox/*.default/chrome/userChrome.css
    ln -s ~/src/dotfiles/firefox/userContent.css ~/.mozilla/firefox/*.default/chrome/userContent.css

Install tree-style-tabs and copy css from dotfiles dir
