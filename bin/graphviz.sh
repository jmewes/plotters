#!/usr/bin/env bash

# https://hub.docker.com/repository/docker/experimentalsoftware/graphviz-dot/tags
# https://gitlab.com/graphviz/graphviz/-/tags
GRAPHVIZ_VERSION=2.50.0

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
  echo "graphviz.sh [-wh] [-f target_format] source_file"
  echo
  echo "See https://graphviz.org/documentation for diagram syntax."
  exit 0
fi

DIAGRAM=$(readlink -f $DIAGRAM)
DIRNAME=$(dirname ${DIAGRAM})
BASENAME=$(basename -- "${DIAGRAM}")
RESULT="${BASENAME%.*}.${FORMAT}"

if [[ $WATCH == 'true' ]]; then
  echo "(Re-)generating $DIRNAME/$RESULT"
  ls $DIAGRAM | entr bash -c "cat ${DIAGRAM} | docker run -i experimentalsoftware/graphviz-dot:${GRAPHVIZ_VERSION} dot -T${FORMAT} > ${DIRNAME}/${RESULT}"
else
  echo "Generating $DIRNAME/$RESULT"
  cat ${DIAGRAM} | docker run -i experimentalsoftware/graphviz-dot:${GRAPHVIZ_VERSION} dot -T${FORMAT} > ${DIRNAME}/${RESULT}
fi
