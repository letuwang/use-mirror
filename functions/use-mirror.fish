function use-mirror
    set -l location $argv[1]

    if test "$location" = "china"
        # Homebrew
        set -Ux HOMEBREW_API_DOMAIN "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
        set -Ux HOMEBREW_BREW_GIT_REMOTE "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
        set -Ux HOMEBREW_CORE_GIT_REMOTE "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
        set -Ux HOMEBREW_BOTTLE_DOMAIN "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
        set -Ux HOMEBREW_PIP_INDEX_URL "https://pypi.tuna.tsinghua.edu.cn/simple"
        if command -q brew
            brew untap homebrew/command-not-found >/dev/null 2>/dev/null
            brew untap homebrew/services >/dev/null 2>/dev/null
        end

        # pip
        set -Ux PIP_INDEX_URL "https://pypi.tuna.tsinghua.edu.cn/simple"

        # fnm
        set -Ux FNM_NODE_DIST_MIRROR "https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/"

        # npm
        npm config set registry https://registry.npmmirror.com

        # poetry
        set -Ux POETRY_PYPI_MIRROR_URL "https://pypi.tuna.tsinghua.edu.cn/simple"

        # rust
        set -Ux RUSTUP_UPDATE_ROOT https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
        set -Ux RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup

    else if test "$location" = "us"
        # Homebrew
        set -e HOMEBREW_API_DOMAIN
        set -e HOMEBREW_BREW_GIT_REMOTE
        set -e HOMEBREW_CORE_GIT_REMOTE
        set -e HOMEBREW_BOTTLE_DOMAIN
        set -e HOMEBREW_PIP_INDEX_URL
        if command -q brew
            brew untap homebrew/command-not-found >/dev/null 2>/dev/null
            brew untap homebrew/services >/dev/null 2>/dev/null
        end

        # pip
        set -Ux PIP_INDEX_URL "https://pypi.org/simple"

        # fnm
        set -Ux FNM_NODE_DIST_MIRROR "https://nodejs.org/dist/"

        # npm
        npm config set registry https://registry.npmjs.org

        # poetry
        set -e POETRY_PYPI_MIRROR_URL

        # rust
        set -e RUSTUP_UPDATE_ROOT
        set -e RUSTUP_DIST_SERVER

    else
        echo "Usage: use-mirror china|us"
    end
end
