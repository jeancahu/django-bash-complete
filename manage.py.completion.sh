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

    if [[ ${COMP_WORDS[1]} == "migrate" || ${COMP_WORDS[1]} == "makemigrations" ]]
    then
        installed_apps=$( python -c "
import os
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'ecomm.settings')
from django.conf import settings
print(\" \".join([app for app in settings.INSTALLED_APPS if not app.startswith(\"django\")]))
")

        COMPREPLY=(
            $(compgen -W "$installed_apps" "${COMP_WORDS[2]}")
        )
        return
    fi

    if (( ${#COMP_WORDS[@]} > 2 ))
    then
        return
    fi

    SUBCOMMANDS="$( ./manage.py help | grep '^ ' | sed '/^ * $/d;/^$/d;:a;N;$!ba;s/\\n/ /g;s/ * / /g' )"
    COMPREPLY=(
        $(compgen -W "$SUBCOMMANDS" "${COMP_WORDS[1]}")
    )
}

complete -F _complete_django_manage ./manage.py
complete -F _complete_django_admin django-admin
