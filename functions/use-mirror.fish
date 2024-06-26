function use-mirror
    set -l location $argv[1]

    if test "$location" = "china"
        # Homebrew
        set -Ux HOMEBREW_API_DOMAIN "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
        set -Ux HOMEBREW_BREW_GIT_REMOTE "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
        set -Ux HOMEBREW_BOTTLE_DOMAIN "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
        set -Ux HOMEBREW_PIP_INDEX_URL "https://pypi.tuna.tsinghua.edu.cn/simple"

        brew tap -v --custom-remote --force-auto-update homebrew/command-not-found https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-command-not-found.git
        brew tap -v --custom-remote --force-auto-update homebrew/services https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-services.git

        brew update

        # pip
        set -Ux PIP_INDEX_URL "https://pypi.tuna.tsinghua.edu.cn/simple"

        # nvm
        set -Ux NVM_MIRROR "https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/"

    else if test "$location" = "us"
        # Homebrew
        set -e HOMEBREW_API_DOMAIN
        set -e HOMEBREW_BREW_GIT_REMOTE
        set -e HOMEBREW_BOTTLE_DOMAIN

        git -C (brew --repo) remote set-url origin https://github.com/Homebrew/brew

        set -l BREW_TAPS (brew tap | tr '\n' ' ')
        for tap in command-not-found services
            if contains "homebrew/$tap" $BREW_TAPS
                brew tap --custom-remote "homebrew/$tap" "https://github.com/Homebrew/homebrew-$tap"
            end
        end

        brew update

        # pip
        set -Ux PIP_INDEX_URL "https://pypi.org/simple"

        # nvm
        set -Ux NVM_MIRROR "https://nodejs.org/dist/"

    else
        echo "Usage: use-mirror china|us"
    end
end