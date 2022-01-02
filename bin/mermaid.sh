#!/usr/bin/env bash

which docker > /dev/null 2>&1 || { echo "ERROR: \`docker\` not installed" ; exit 1; }
which readlink > /dev/null 2>&1 || { echo "ERROR: \`readlink\` not installed" ; exit 1; }
which dirname > /dev/null 2>&1 || { echo "ERROR: \`dirname\` not installed" ; exit 1; }
which basename > /dev/null 2>&1 || { echo "ERROR: \`basename\` not installed" ; exit 1; }

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

if [[ $WATCH == 'true' ]]; then
  which entr > /dev/null 2>&1
  if [[ $? -eq 0 ]]; then
    echo "(Re-)generating $DIRNAME/$RESULT"
    ls $DIAGRAM | entr bash -c "docker run -u $UID -it -v ${DIRNAME}:/data minlag/mermaid-cli:${MERMAID_VERSION} -i /data/${BASENAME} --output /data/${RESULT}"
  else
    echo "ERROR: You need to have \`entr\` installed to be able to use the \`-w\` flag."
    echo "See https://github.com/experimental-software/plotters/wiki/entr for setup instructions."
    exit 1
  fi
else
  echo "Generating $DIRNAME/$RESULT"
  docker run -u $UID -it -v ${DIRNAME}:/data minlag/mermaid-cli:${MERMAID_VERSION} -i /data/${BASENAME} --output /data/${RESULT}
fi
