#!/usr/bin/env bash
# Load specified i3 layout

while getopts :cl:w: opt;
do
  case $opt in
    c)
      CUSTOM_COMMANDS=true
      ;;
    l)
      LAYOUT=$OPTARG
      ;;
    w)
      WORKSPACE=$OPTARG
      ;;
  esac
done

# ref: http://stackoverflow.com/a/13864829
if [[ -z ${LAYOUT+x} ]];
then
  echo "Layout (-l) not specified. Quitting."
  exit 1
else
  LAYOUT_PATH="/home/$(id -un)/.i3/layouts/$LAYOUT.json"
  if [[ ! -f "$LAYOUT_PATH" ]];
  then
    echo "Layout ($LAYOUT_PATH) doesn't exist. Quitting."
    exit 1
  fi
  LAYOUT_COMMANDS_PATH="/home/$(id -un)/.i3/layouts/$LAYOUT.commands"
fi
if [[ -z ${WORKSPACE+x} ]];
then
  FOCUSED_WORKSPACE=$(i3-msg -t get_workspaces | python -m json.tool | grep -A2 '"focused": true' | tail -n1 | cut -d ':' -f2 | cut -d ',' -f1)
  WORKSPACE=$FOCUSED_WORKSPACE
fi

# ref: http://stackoverflow.com/a/8013232
LAYOUT_COMMAND_STING=$(
while read line
do
  echo -n "exec ${line};"
done < $LAYOUT_COMMANDS_PATH)

i3_COMMAND="workspace $WORKSPACE; append_layout $LAYOUT_PATH"
if [[ -z ${CUSTOM_COMMANDS+x} ]];
then
  i3_COMMAND="$i3_COMMAND; $LAYOUT_COMMAND_STING"
  i3-msg "$i3_COMMAND"
else
  echo "$i3_COMMAND"
fi

