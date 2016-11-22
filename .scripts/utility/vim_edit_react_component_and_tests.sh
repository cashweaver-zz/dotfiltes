#!/usr/bin/env bash
# Easy-open for React components and their tests.
# Specify the components (by directory name) and vim will open a window for each component.

CWD=$(pwd)

function open_component {
  # remove trailing slash, if it exists
  COMPONENT=${1%/}
  # Open the component in a tab
  VIM_COMMAND+="-c \":tabnew $CWD/$COMPONENT/index.jsx\""
  VIM_COMMAND+=" "
}

function open_component_tests {
  # remove trailing slash, if it exists
  COMPONENT=${1%/}
  TESTS_PATH="$CWD/$COMPONENT/$COMPONENT.test.jsx"
  if [[ -f "$TESTS_PATH" ]]; then
    # Open the component's test in a split
    VIM_COMMAND+="-c \":vsp $TESTS_PATH\""
    VIM_COMMAND+=" "
  fi
}

if [ $# -gt 0 ]; then
  VIM_COMMAND="vim "

  # remove trailing slash, if it exists
  COMPONENT=${1%/}
  # Open first component without -c to prevent vim from opening an empty file
  VIM_COMMAND+="$CWD/$COMPONENT/index.jsx"
  VIM_COMMAND+=" "
  open_component_tests $1
  shift

  while [ "$1" != "" ]; do
    open_component $1
    open_component_tests $1
    shift
  done

  eval $VIM_COMMAND
else
  echo "No directories specified. Stopping."
fi
