#!/usr/bin/env bash

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

if [[ $WATCH == 'true' ]]; then
  echo "(Re-)generating $DIRNAME/$RESULT"
  ls $DIAGRAM | entr bash -c "docker run -it -v ${DIRNAME}:/data rlespinasse/drawio-export:${DRAWIO_EXPORT_VERSION} /data/${BASENAME} --format ${FORMAT} --border 25 --output /data --remove-page-suffix"
else
  echo "Generating $DIRNAME/$RESULT"
  docker run -it -v ${DIRNAME}:/data rlespinasse/drawio-export:${DRAWIO_EXPORT_VERSION} /data/${BASENAME} --format ${FORMAT} --border 25 --output /data --remove-page-suffix
fi
