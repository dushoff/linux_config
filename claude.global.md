# User-wide instructions (all projects, all machines)

Curated in dushoff/linux_config (claude.global.md); linked to ~/.claude/CLAUDE.md by `make linkclaude`.

## Symlinked dotfiles

Most dotfiles in ~ (.vimrc*, .bashrc, .aliases, .profile, ~/Makefile, nvim/i3/alacritty configs, ...) are symlinks into the linux_config repo (usually ~/terminal/dirs/config/home or ~/screens/tech/linux_config).

- Before editing anything in ~ or ~/.config, check `ls -l`; if it's a link, edit the target (`readlink -f`) in the repo.
- Never use `sed -i`, `perl -i`, `cp`/`mv` over the path, or anything else that replaces the file: it turns the symlink into a regular file and silently forks it from the repo. The Edit tool on the link path is fine.
- After editing, mention that the change is uncommitted in linux_config.
