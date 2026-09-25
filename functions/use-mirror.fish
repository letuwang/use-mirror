function use-mirror
    set -l location $argv[1]

    if test "$location" = "china"
        # Homebrew
        set -Ux HOMEBREW_API_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles/api"
        set -Ux HOMEBREW_BREW_GIT_REMOTE "https://mirrors.ustc.edu.cn/brew.git"
        set -e HOMEBREW_CORE_GIT_REMOTE
        set -Ux HOMEBREW_BOTTLE_DOMAIN "https://mirrors.ustc.edu.cn/homebrew-bottles"
        set -Ux HOMEBREW_PIP_INDEX_URL "https://mirrors.ustc.edu.cn/pypi/simple"
        if command -q brew
            brew untap homebrew/command-not-found >/dev/null 2>/dev/null
            brew untap homebrew/services >/dev/null 2>/dev/null
        end

        # pip
        set -Ux PIP_INDEX_URL "https://mirrors.ustc.edu.cn/pypi/simple"
        use-mirror-pip-conf "https://mirrors.ustc.edu.cn/pypi/simple"

        # fnm
        set -Ux FNM_NODE_DIST_MIRROR "https://mirrors.ustc.edu.cn/node/"

        # mise
        if command -q mise
            mise settings set node.mirror_url "https://mirrors.aliyun.com/nodejs-release/"
        end

        # npm
        npm config set registry https://registry.npmmirror.com

        # poetry
        set -Ux POETRY_PYPI_MIRROR_URL "https://mirrors.ustc.edu.cn/pypi/simple"

        # rust
        set -Ux RUSTUP_UPDATE_ROOT https://mirrors.ustc.edu.cn/rust-static/rustup
        set -Ux RUSTUP_DIST_SERVER https://mirrors.ustc.edu.cn/rust-static

    else if test "$location" = "us"
        # Homebrew
        for var in HOMEBREW_API_DOMAIN HOMEBREW_BREW_GIT_REMOTE HOMEBREW_CORE_GIT_REMOTE HOMEBREW_BOTTLE_DOMAIN HOMEBREW_PIP_INDEX_URL
            if set -q $var
                set -e $var
            end
        end
        if command -q brew
            set -l brew_repo (brew --repo)
            if test -d "$brew_repo/.git"
                git -C "$brew_repo" remote set-url origin https://github.com/Homebrew/brew
            end
            for tap in core cask
                set -l tap_repo (brew --repository "homebrew/$tap" 2>/dev/null)
                if test -d "$tap_repo/.git"
                    git -C "$tap_repo" remote set-url origin "https://github.com/Homebrew/homebrew-$tap"
                end
            end
            brew untap homebrew/command-not-found >/dev/null 2>/dev/null
            brew untap homebrew/services >/dev/null 2>/dev/null
        end

        # pip
        set -Ux PIP_INDEX_URL "https://pypi.org/simple"
        use-mirror-pip-conf "https://pypi.org/simple"

        # fnm
        set -Ux FNM_NODE_DIST_MIRROR "https://nodejs.org/dist/"

        # mise
        if command -q mise
            mise settings set node.mirror_url "https://nodejs.org/dist/"
        end

        # npm
        if command -q npm
            npm config set registry https://registry.npmjs.org
        end

        # poetry
        for var in POETRY_PYPI_MIRROR_URL RUSTUP_UPDATE_ROOT RUSTUP_DIST_SERVER
            if set -q $var
                set -e $var
            end
        end

    else
        echo "Usage: use-mirror china|us"
    end
end
