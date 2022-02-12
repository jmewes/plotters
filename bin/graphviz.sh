#!/usr/bin/env bash

which docker > /dev/null 2>&1 || { echo "ERROR: \`docker\` not installed" ; exit 1; }
which readlink > /dev/null 2>&1 || { echo "ERROR: \`readlink\` not installed" ; exit 1; }
which dirname > /dev/null 2>&1 || { echo "ERROR: \`dirname\` not installed" ; exit 1; }
which basename > /dev/null 2>&1 || { echo "ERROR: \`basename\` not installed" ; exit 1; }

# https://hub.docker.com/repository/docker/experimentalsoftware/graphviz-dot/tags
# https://gitlab.com/graphviz/graphviz/-/tags
GRAPHVIZ_VERSION=2.50.0

FORMAT="png"

USAGE=`cat <<EOF
Graphviz wrapper, version ${GRAPHVIZ_VERSION}

Renders a binary image as a sibling of a Graphviz source file.

Usage:  graphviz.sh [option] source-file
Examples:
        graphviz.sh hello-world.dot
        graphviz.sh -f svg hello-world.dot
        graphviz.sh -w hello-world.dot
Options:
        -f  The format of the generated image.
        -w  Watch file changes and re-render the diagram every time the file changes.
        -h  Print the help text.
Diagram syntax:
        https://graphviz.org/documentation
EOF
`

while getopts "f: w h" flag; do
case "$flag" in
    h) HELP='true';;
    w) WATCH='true';;
    f) FORMAT=$OPTARG;;
esac
done

DIAGRAM=${@:$OPTIND:1}

if [[ $HELP == 'true' || -z "$DIAGRAM" ]]; then
  echo "${USAGE}" >&2
  exit 1
fi

DIAGRAM=$(readlink -f $DIAGRAM)
DIRNAME=$(dirname ${DIAGRAM})
BASENAME=$(basename -- "${DIAGRAM}")
RESULT="${BASENAME%.*}.${FORMAT}"

if [[ $WATCH == 'true' ]]; then
  which entr > /dev/null 2>&1
  if [[ $? -eq 0 ]]; then
    echo "(Re-)generating $DIRNAME/$RESULT"
    ls $DIAGRAM | entr bash -c "cat ${DIAGRAM} | docker run -i experimentalsoftware/graphviz-dot:${GRAPHVIZ_VERSION} dot -T${FORMAT} > ${DIRNAME}/${RESULT}"
  else
    echo "ERROR: You need to have \`entr\` installed to be able to use the \`-w\` flag." >&2
    echo "See https://github.com/experimental-software/plotters/wiki/entr for setup instructions." >&2
    exit 1
  fi
else
  echo "Generating $DIRNAME/$RESULT"
  cat ${DIAGRAM} | docker run -i experimentalsoftware/graphviz-dot:${GRAPHVIZ_VERSION} dot -T${FORMAT} > ${DIRNAME}/${RESULT}
fi
