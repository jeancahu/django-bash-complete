
function _complete_django_admin () {
    if (( ${#COMP_WORDS[@]} > 2 ))
    then
        return
    fi

    SUBCOMMANDS="$( django-admin | sed -n '/^ /p' | sed ';:a;N;$!ba;s/\n/ /g;s/ * / /g' )"

    COMPREPLY=(
        $(compgen -W "$SUBCOMMANDS" "${COMP_WORDS[1]}")
              )
}

function _complete_django_manage () {
    ## Load/dump data auto complete:
    if [[ ${COMP_WORDS[1]} == "loaddata" || ${COMP_WORDS[1]} == "dumpdata" ]]
    then
        COMPREPLY=(
            $(compgen -W "$( echo *.json | grep -v '*.json' )" "${COMP_WORDS[2]}")
        )
        return
    fi

    if (( ${#COMP_WORDS[@]} > 2 ))
    then
        return
    fi

    SUBCOMMANDS="changepassword createsuperuser remove_stale_contenttypes check compilemessages createcachetable dbshell diffsettings dumpdata flush inspectdb loaddata makemessages makemigrations migrate sendtestemail shell showmigrations sqlflush sqlmigrate sqlsequencereset squashmigrations startapp startproject test testserver clearsessions collectstatic findstatic runserver"

    COMPREPLY=(
        $(compgen -W "$SUBCOMMANDS" "${COMP_WORDS[1]}")
    )
}

complete -F _complete_django_manage ./manage.py
complete -F _complete_django_admin django-admin
