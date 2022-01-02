#!/bin/bash

FORMAT="png"
MERMAID_VERSION=8.13.5 # https://github.com/mermaid-js/mermaid-cli/tags

while getopts "f: w h" flag; do
case "$flag" in
    h) HELP='true';;
    w) WATCH='true';;
    f) FORMAT=$OPTARG;;
esac
done

DIAGRAM=${@:$OPTIND:1}

if [[ $HELP == 'true' || -z "$DIAGRAM" ]]; then
  echo "mermaid.sh [-wh] [-f target_format] source_file"
  echo
  echo "See https://mermaid-js.github.io for diagram syntax."
  exit 0
fi

DIAGRAM=$(readlink -f $DIAGRAM)
DIRNAME=$(dirname ${DIAGRAM})
BASENAME=$(basename -- "${DIAGRAM}")
RESULT="${BASENAME%.*}.${FORMAT}"

# docker run -it minlag/mermaid-cli

if [[ $WATCH == 'true' ]]; then
  echo "(Re-)generating $DIRNAME/$RESULT"
  ls $DIAGRAM | entr bash -c "docker run -u $UID -it -v ${DIRNAME}:/data minlag/mermaid-cli:${MERMAID_VERSION} -i /data/${BASENAME} --output /data/${RESULT}"
else
  echo "Generating $DIRNAME/$RESULT"
  docker run -u $UID -it -v ${DIRNAME}:/data minlag/mermaid-cli:${MERMAID_VERSION} -i /data/${BASENAME} --output /data/${RESULT}
fi
