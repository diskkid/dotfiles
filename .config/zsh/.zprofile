# path_helper hack
if [ "$(uname)" = 'Darwin' ]; then
  typeset -U PATH
  PATH=$BACKUP_PATH:$PATH
  unset BACKUP_PATH
fi
