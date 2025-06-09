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

        # fnm
        set -Ux FNM_NODE_DIST_MIRROR "https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/"

        # npm
        npm config set registry https://registry.npmmirror.com --location=global

        # poetry
        set -Ux POETRY_PYPI_MIRROR_URL "https://pypi.tuna.tsinghua.edu.cn/simple"

        # rust
        set -Ux RUSTUP_UPDATE_ROOT https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
        set -Ux RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup

    else if test "$location" = "us"
        # Homebrew
        set -e HOMEBREW_API_DOMAIN
        set -e HOMEBREW_BREW_GIT_REMOTE
        set -e HOMEBREW_BOTTLE_DOMAIN
        set -e HOMEBREW_PIP_INDEX_URL

        git -C (brew --repo) remote set-url origin https://github.com/Homebrew/brew

        brew tap -v --custom-remote --force-auto-update homebrew/command-not-found https://github.com/Homebrew/homebrew-command-not-found
        brew tap -v --custom-remote --force-auto-update homebrew/services https://github.com/Homebrew/homebrew-services

        brew update

        # pip
        set -Ux PIP_INDEX_URL "https://pypi.org/simple"

        # fnm
        set -Ux FNM_NODE_DIST_MIRROR "https://nodejs.org/dist/"

        # npm
        npm config set registry https://registry.npmjs.org --location=global

        # poetry
        set -e POETRY_PYPI_MIRROR_URL

        # rust
        set -e RUSTUP_UPDATE_ROOT

    else
        echo "Usage: use-mirror china|us"
    end
end