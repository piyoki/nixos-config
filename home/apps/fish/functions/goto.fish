function __goto_usage
    printf "\
 usage: goto [<option>] <alias> [<directory>]

 default usage:
    goto <alias> - changes to the directory registered for the given alias

 OPTIONS:
    -r, --register: registers an alias
      goto -r|--register <alias> <directory>
    -u, --unregister: unregisters an alias
      goto -u|--unregister <alias>
    -l, --list: lists aliases
      goto -l|--list
    -x, --expand: expands an alias
      goto -x|--expand <alias>
    -c, --cleanup: cleans up non existent directory aliases
      goto -c|--cleanup
    -v, --version: prints version
      goto -v|--version
    -h, --help: prints this help
      goto -h|--help\n"
end

function __goto_get_db
    if test -f "$GOTO_DB"
        echo "$GOTO_DB"
    else if test -d "$XDG_DATA_HOME"
        mkdir -p "$XDG_DATA_HOME/goto"
        touch -a "$XDG_DATA_HOME/goto/db"
        echo "$XDG_DATA_HOME/goto/db"
    else
        mkdir -p "$HOME/.local/share/goto"
        touch -a "$HOME/.local/share/goto/db"
        echo "$HOME/.local/share/goto/db"
    end
end

function __goto_register
    if test (count $argv) -lt 3
        echo 'usage: goto -r|--register <alias> <directory>'
        return 1
    end
    set acronym $argv[2]
    set directory $argv[3]

    if not test (string match -r '^[\d\w_-]+$' $acronym)
        echo "Invalid alias: '$acronym'. Alises can contain only letters, \
digits, hyphens and underscores."
        return 1
    end

    if not test -d $directory
        echo "Directory: '$directory' does not exists."
        return 1
    end

    if test (__goto_find_directory $acronym) != ''
        echo "Alias already exists."
        return 1
    end

    echo -e $acronym\t(realpath $directory) >> (__goto_get_db)
    if test $status -eq 0
        echo 'Alias successfully registered.'
    else
        echo 'Unable to register alias.'
        return 1
    end
end

function __goto_find_directory
    echo (__goto_list | string match -r "^$argv\s(.+)\$")[2]
end

function __goto_directory
    set directory (__goto_find_directory $argv)

    if test $directory = ""
        echo "Alias: '$argv' not found."
        return 1
    end

    cd $directory
    if test $status -ne 0
        echo "Failed to goto: '$directory'."
        return 1
    end
end

function __goto_list
    cat (__goto_get_db) | string replace -r '\s' '\t' | sort
end

function __goto_unregister
    if test (count $argv) -lt 2
        echo 'usage: goto -u|--unregister <alias>'
        return 1
    end
    set db (__goto_get_db)
    set acronym $argv[2]
    set tmp_db $HOME/.goto_tmp
    cat $db | string match -r "^(?!$acronym\s).+" > $tmp_db
    mv $tmp_db $db
    echo 'Alias successfully unregistered.'
end

function __goto_expand
    if test (count $argv) -lt 2
        echo 'usage: goto -x|--expand <alias>'
        return 1
    end
    echo (__goto_find_directory $argv[2])
end

function __goto_cleanup
    set db (__goto_get_db)
    set tmp_db $HOME/.goto_tmp
    touch $tmp_db
    for line in (__goto_list)
        if test -d (realpath (string replace -r '.*\s' '' $line))
            echo $line >> $tmp_db
        else
            set acronym (string replace -r '.*\s' '' $line)
            echo "Removing: '$acronym'."
        end
    end
    mv $tmp_db $db
end

function ___goto_version
    echo "1.1.1"
end

function __goto_find_aliases
    __goto_list | string match -r '.+?\s'
end

function goto -d 'quickly navigate to aliased directories'
    if test (count $argv) -lt 1
        __goto_usage
        return 1
    end
    __goto_get_db > /dev/null
    switch $argv[1]
        case -r or --register
            __goto_register $argv
        case -u or --unregister
            __goto_unregister $argv
        case -l or --list
            __goto_list
        case -x or --expand
            __goto_expand $argv
        case -c or --cleanup
            __goto_cleanup
        case -h or --help
            __goto_usage
        case -v or --version
            ___goto_version
        case '*'
            __goto_directory $argv[1]
    end
    return $status
end

__goto_get_db > /dev/null
# goto completions
complete -c goto -x -n "test (count (commandline -opc)) -lt 2" -a "(__goto_find_aliases)"
complete -c goto -x -s u -l unregister -d "unregister an alias" -a "(__goto_find_aliases)"
complete -c goto -x -s x -l expand -d "expands an alias" -a "(__goto_find_aliases)"
complete -c goto -x -s r -l register -d "register an alias"
complete -c goto -x -s h -l help -d "prints help message"
complete -c goto -x -s l -l list -d "lists aliases"
complete -c goto -x -s c -l cleanup -d "deletes non existent directory aliases"
complete -c goto -x -s v -l version -d "prints version"
