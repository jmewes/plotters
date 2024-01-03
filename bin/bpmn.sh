#!/usr/bin/env bash

which docker > /dev/null 2>&1 || { echo "ERROR: \`docker\` not installed" ; exit 1; }
which perl > /dev/null 2>&1 || { echo "ERROR: \`perl\` not installed" ; exit 1; }
which dirname > /dev/null 2>&1 || { echo "ERROR: \`dirname\` not installed" ; exit 1; }
which basename > /dev/null 2>&1 || { echo "ERROR: \`basename\` not installed" ; exit 1; }

USAGE=`cat <<EOF
bpmn-to-image wrapper

Renders a PNG file as a sibling of a BPMN source file.

Usage:  bpmn.sh [option] source-file

Examples:
        bpmn.sh hello-world.bpmn

Options:
        -h  Print the help text.
EOF
`

while getopts "f: h" flag; do
case "$flag" in
    h) HELP='true';;
esac
done

DIAGRAM=${@:$OPTIND:1}

if [[ $HELP == 'true' || -z "$DIAGRAM" ]]; then
  echo "${USAGE}" >&2
  exit 1
fi

set -e
DIAGRAM=$(perl -MCwd -e 'print Cwd::abs_path shift' ${DIAGRAM})
DIRNAME=$(dirname ${DIAGRAM})
BASENAME=$(basename -- "${DIAGRAM}")
RESULT="${BASENAME%.*}.png"
set +e

docker run --rm -v ${DIRNAME}:/app experimentalsoftware/bpmn-to-image bpmn-to-image ${BASENAME}:${RESULT} --no-footer
