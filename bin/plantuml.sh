#!/usr/bin/env bash

# https://hub.docker.com/r/karfau/plantuml/tags
# See https://github.com/karfau/plantuml-docker/blob/main/build.gradle for used PlantUML version
# See https://plantuml.com/download for current PlantUML version
PLANTUML_VERSION=1.2021.16

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
  echo "plantuml.sh [-wh] [-f target_format] source_file"
  echo
  echo "See https://plantuml.com for diagram syntax."
  exit 0
fi

DIAGRAM=$(readlink -f $DIAGRAM)
DIRNAME=$(dirname ${DIAGRAM})
BASENAME=$(basename -- "${DIAGRAM}")
RESULT="${BASENAME%.*}.${FORMAT}"

if [[ $WATCH == 'true' ]]; then
  echo "(Re-)generating $DIRNAME/$RESULT"
  ls $DIAGRAM | entr bash -c "cat ${DIAGRAM} | docker run -i karfau/plantuml:${PLANTUML_VERSION} -pipe -t${FORMAT} > ${DIRNAME}/${RESULT}"
else
  echo "Generating $DIRNAME/$RESULT"
  cat ${DIAGRAM} | docker run -i karfau/plantuml:${PLANTUML_VERSION} -pipe -t${FORMAT} > "${DIRNAME}/${RESULT}"
fi
