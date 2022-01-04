#!/usr/bin/env bash

which docker > /dev/null 2>&1 || { echo "ERROR: \`docker\` not installed" ; exit 1; }
which readlink > /dev/null 2>&1 || { echo "ERROR: \`readlink\` not installed" ; exit 1; }
which dirname > /dev/null 2>&1 || { echo "ERROR: \`dirname\` not installed" ; exit 1; }
which basename > /dev/null 2>&1 || { echo "ERROR: \`basename\` not installed" ; exit 1; }

# https://github.com/rlespinasse/drawio-export/tags
# https://github.com/rlespinasse/docker-drawio-desktop-headless/blob/v1.x/Dockerfile#L5
# https://github.com/jgraph/drawio-desktop/tags
DRAWIO_EXPORT_VERSION=4.3.0

FORMAT="png"

while getopts "f: w h" flag; do
case "$flag" in
    h) HELP='true';;
    w) WATCH='true';;
    f) FORMAT=$OPTARG;;
esac
done

DIAGRAM=${@:$OPTIND:1}

if [[ $HELP == 'true' || -z "$DIAGRAM" ]]; then
  echo "drawio.sh [-wh] [-f target_format] source_file"
  echo
  echo "See https://www.diagrams.net for DrawIO documentation."
  exit 0
fi

DIAGRAM=$(readlink -f $DIAGRAM)
DIRNAME=$(dirname ${DIAGRAM})
BASENAME=$(basename -- "${DIAGRAM}")
RESULT="${BASENAME%.*}.${FORMAT}"


COMPILE_DIAGRAM_CMD="docker run -it -v ${DIRNAME}:/data rlespinasse/drawio-export:${DRAWIO_EXPORT_VERSION} /data/${BASENAME} --format ${FORMAT} --border 25 --output /data --remove-page-suffix"

# Workaround for 'drawio-export' container insisting on running as root which
# will lead to the generated file being owned by root.
CHANGE_OWNER_CMD="docker run -it -v ${DIRNAME}:/data debian:buster bash -c 'chown $UID:$UID /data/${RESULT}'"

if [[ $WATCH == 'true' ]]; then
  which entr > /dev/null 2>&1
  if [[ $? -eq 0 ]]; then
    echo "(Re-)generating $DIRNAME/$RESULT"
    ls $DIAGRAM | entr bash -c "eval \"${COMPILE_DIAGRAM_CMD}\" && eval \"${CHANGE_OWNER_CMD}\""
  else
    echo "ERROR: You need to have \`entr\` installed to be able to use the \`-w\` flag."
    echo "See https://github.com/experimental-software/plotters/wiki/entr for setup instructions."
    exit 1
  fi
else
  echo "Generating $DIRNAME/$RESULT"
  eval "${COMPILE_DIAGRAM_CMD}"
  eval "${CHANGE_OWNER_CMD}"
fi
