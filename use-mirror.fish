#!/usr/bin/env fish

function use-mirror
    set -l location $argv[1]

    if test "$location" = "china"
        # Set Homebrew to use Chinese mirrors
        set -Ux HOMEBREW_API_DOMAIN "https://mirrors.aliyun.com/homebrew-bottles/api"
        set -Ux HOMEBREW_BREW_GIT_REMOTE "https://mirrors.aliyun.com/homebrew/brew.git"
        set -Ux HOMEBREW_CORE_GIT_REMOTE "https://mirrors.aliyun.com/homebrew/homebrew-core.git"
        set -Ux HOMEBREW_BOTTLE_DOMAIN "https://mirrors.aliyun.com/homebrew/homebrew-bottles"

        brew tap -v --custom-remote --force-auto-update homebrew/core https://mirrors.aliyun.com/homebrew/homebrew-core.git
        brew tap -v --custom-remote --force-auto-update homebrew/cask https://mirrors.aliyun.com/homebrew/homebrew-cask.git
        brew tap -v --custom-remote --force-auto-update homebrew/cask-fonts https://mirrors.aliyun.com/homebrew/homebrew-cask-fonts.git
        brew tap -v --custom-remote --force-auto-update homebrew/cask-versions https://mirrors.aliyun.com/homebrew/homebrew-cask-versions.git
        brew tap -v --custom-remote --force-auto-update homebrew/command-not-found https://mirrors.aliyun.com/homebrew/homebrew-command-not-found.git
        brew tap -v --custom-remote --force-auto-update homebrew/services https://mirrors.aliyun.com/homebrew/homebrew-services.git

        brew update

    else if test "$location" = "us"
        # Unset all mirrors and use default hosts
        set -e HOMEBREW_API_DOMAIN
        set -e HOMEBREW_BREW_GIT_REMOTE
        set -e HOMEBREW_CORE_GIT_REMOTE
        set -e HOMEBREW_BOTTLE_DOMAIN

        # Reset Git remotes
        git -C (brew --repo) remote set-url origin https://github.com/Homebrew/brew

        # Reset all taps
        set -l BREW_TAPS (brew tap | tr '\n' ' ')
        for tap in core cask cask-fonts cask-versions command-not-found services
            if contains "homebrew/$tap" $BREW_TAPS
                brew tap --custom-remote "homebrew/$tap" "https://github.com/Homebrew/homebrew-$tap"
            end
        end

        brew update

    else
        echo "Usage: use-mirror china|us"
    end
end