FROM debian:9

LABEL "com.github.actions.name"="Check Branch"
LABEL "com.github.actions.description"="Checks that the trigger branch equals the argument given."
LABEL "com.github.actions.icon"="git-branch"
LABEL "com.github.actions.color"="gray-dark"

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
