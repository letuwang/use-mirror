function use-mirror-pip-conf --argument-names index_url --description "Keep ~/.config/pip/pip.conf in step with the chosen mirror. Non-fish processes (zsh, launchd) never see universal vars, so the file must agree with PIP_INDEX_URL or pip/uv tools silently split across two indexes."
    set -l conf_file ~/.config/pip/pip.conf
    mkdir -m 700 -p (dirname $conf_file)
    printf '[global]\nindex-url = %s\n' $index_url >$conf_file.new
    if not cmp -s $conf_file.new $conf_file
        mv $conf_file.new $conf_file
    else
        rm $conf_file.new
    end
end
