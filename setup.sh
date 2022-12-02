#/usr/bin/env bash

# Make old dotfiles dir
DOTFILES_OLD_DIR="${HOME}/dotfiles_old"
mkdir -p "${DOTFILES_OLD_DIR}"

# Get git dotfiles
DOTFILES="$(find $(pwd)/dotfiles -type f -name ".*")"

for f in ${DOTFILES} ; do
  DOTFILE="${HOME}/$(basename ${f})"

  # Backup old dotfile
  mv -f "${DOTFILE}" "${DOTFILES_OLD_DIR}/"

  # Symlink new dotfile
  ln -s -v "${f}" "${HOME}"
done

echo "Setup complete. Restart your Terminal"
