set -e

function header_index {
  if [ $# -ne 2 ]; then
    echo "header_index called w/o correct arguments" 1>&2
    exit -1
  fi
  INDEX=$(echo "$2" | awk -v b="$1" '{for (i=1;i<=NF;i++) { if ($i == b) { print i } }}')
  echo "$INDEX"
}

function required_header_index {
  if [ $# -ne 2 ]; then
    echo "required_header_index called w/o correct arguments" 1>&2
    exit -1
  fi
  INDEX=$(header_index "$1" "$2")
  if [ -z "$INDEX" ]; then
    echo "Unable to find (required) \"$1\" in header line: $2" 1>&2
    exit -1;
  fi
  echo "$INDEX"
}


function get_header_line {
  if [ $# -ne 1 ]; then
    echo "get_header_line called w/o correct arguments" 1>&2
    exit -1
  fi
  HEADER=$(grep -m 1 ' Device' "$1")
  if [ -z "$HEADER" ]; then
    echo "Unable to find header line in $1" 1>&2
    exit -1;
  fi
  echo "$HEADER"
}
