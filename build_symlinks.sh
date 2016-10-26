#!/usr/bin/env bash
# Create symlinks for all dotfiles. Backup original files.

DOTFILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKUP_DIR="/home/$(whoami)/.dotfilebak"

# Create backup directory.
# Exit if the directory already exists.
if [ -d "$BACKUP_DIR" ]; then
  echo "Backup directory ($BACKUP_DIR) already exists. Exiting to prevent overwriting files."
  exit 1
fi
mkdir "$BACKUP_DIR"

# All files in directory
FILES=$(cd $DOTFILE_DIR && ls -A)
FILES=($FILES)

# Select only the dotfiles we're interested in
DOTFILES=()
for file in "${FILES[@]}"
do
  [[ $file != .git ]] && [[ $file != build_symlinks.sh ]] && DOTFILES+=($file)
done
unset FILES
echo $DOTFILES


# Create backup and symbolic links
cd $BACKUP_DIR
cd ..
for dotfile in "${DOTFILES[@]}"
do
  mv $dotfile .dotfilebak/ 2>/dev/null
  ln -s "$DOTFILE_DIR/$dotfile" $dotfile
done

# Local files must be handled individually as they aren't include in the dotfile directory.
mv .bashrc.local .dotfilebak/ 2>/dev/null
touch .bashrc.local

mv .bash_aliases.local .dotfilebak/ 2>/dev/null
touch .bash_aliases.local

source .bashrc

echo "Existing files were backed up to:"
echo "  /home/$(whoami)/.dotfilebak"
