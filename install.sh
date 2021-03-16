#!/bin/bash

# Install packages
echo "Running update"
sudo pacman -Syu
sudo pacman --noconfirm --needed -S $(cat ~/.dotfiles/chroot/nonAUR.txt)
yay -S --noconfirm --needed $(cat ~/.dotfiles/chroot/AUR.txt)

# Initial cleanup
echo "Backing up your previous dotfiles to ~/.dotfiles_backup"
mkdir -p ~/.local/share
mkdir -p ~/.dotfiles_backup
mkdir -p ~/.config
mkdir -p ~/.dotfiles_backup/.config

rsync --remove-source-files -avzh --ignore-errors \
  ~/.completions \
  ~/.aliases \
  ~/.cmds \
  ~/.zshrc \
  ~/.Xresources \
  ~/.xmodmap \
  ~/.xinitrc \
  ~/.tmux.conf \
  ~/.surf \
  ~/.scripts \
  ~/.keyboard \
  ~/.fzf.zsh \
  ~/.themes \
  ~/.vim \
  ~/.vimrc \
  ~/.dotfiles_backup

rsync --remove-source-files -avzh --ignore-errors \
  ~/.config/htop \
  ~/.config/.profile \
  ~/.config/systemd \
  ~/.config/termite \
  ~/.config/zathura \
  ~/.config/dunst \
  ~/.config/gtk-4.0 \
  ~/.config/gtk-3.0 \
  ~/.config/gtk-2.0 \
  ~/.config/antibody \
  ~/.config/suckless \
  ~/.dotfiles_backup/.config

rm -rf \
  ~/.completions \
  ~/.aliases \
  ~/.cmds \
  ~/.zshrc \
  ~/.Xresources \
  ~/.xmodmap \
  ~/.xinitrc \
  ~/.tmux.conf \
  ~/.surf \
  ~/.scripts \
  ~/.keyboard \
  ~/.fzf.zsh \
  ~/.themes \
  ~/.vim \
  ~/.vimrc \
  ~/.config/htop \
  ~/.config/.profile \
  ~/.config/systemd \
  ~/.config/termite \
  ~/.config/zathura \
  ~/.config/dunst \
  ~/.config/gtk-4.0 \
  ~/.config/gtk-3.0 \
  ~/.config/gtk-2.0 \
  ~/.config/antibody \
  ~/.config/suckless

# Vim
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
ln -s ~/.dotfiles/vim/vim ~/.vim

# GTK
ln -s ~/.dotfiles/gtk/themes ~/.themes
ln -s ~/.dotfiles/gtk/gtk-2.0 ~/.config/gtk-2.0
ln -s ~/.dotfiles/gtk/gtk-3.0 ~/.config/gtk-3.0
ln -s ~/.dotfiles/gtk/gtk-4.0 ~/.config/gtk-4.0

# Miscellaneous
ln -s ~/.dotfiles/misc/dunst ~/.config/dunst
ln -s ~/.dotfiles/misc/zathura ~/.config/zathura
ln -s ~/.dotfiles/misc/termite/ ~/.config/termite
ln -s ~/.dotfiles/misc/systemd ~/.config/systemd
ln -s ~/.dotfiles/misc/neofetch ~/.config/neofetch
ln -s ~/.dotfiles/misc/profile ~/.config/.profile
ln -s ~/.dotfiles/misc/htop ~/.config/htop
ln -s ~/.dotfiles/misc/.fzf.zsh ~/.fzf.zsh
ln -s ~/.dotfiles/misc/keyboard ~/.keyboard
ln -s ~/.dotfiles/misc/mimeapps.list ~/.config/mimeapps.list
ln -s ~/.dotfiles/fonts ~/.fonts
fc-cache

# Applications
for d in ~/.dotfiles/applications/* ; do
  ln -s $d ~/.local/share/applications/
done
# Scripts
ln -s ~/.dotfiles/scripts ~/.scripts

# Suckless
ln -s ~/.dotfiles/suckless ~/.config/suckless
ln -s ~/.dotfiles/suckless/dot_surf ~/.surf
yay -S xsel clipnotify
yay -S ttf-symbola
~/.dotfiles/suckless/build.sh

# Tmux
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

# Xorg
ln -s ~/.dotfiles/xorg/xinitrc ~/.xinitrc
ln -s ~/.dotfiles/xorg/xmodmap ~/.xmodmap
ln -s ~/.dotfiles/xorg/Xresources ~/.Xresources

# Zsh
ln -s ~/.dotfiles/zsh/antibody ~/.config/antibody
ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/.dotfiles/zsh/secret ~/.zsh_secret
ln -s ~/.dotfiles/zsh/cmds ~/.cmds
ln -s ~/.dotfiles/zsh/aliases ~/.aliases
ln -s ~/.dotfiles/zsh/completions ~/.completions

# Mail
ln -s ~/.dotfiles/mail/mutt ~/.config/mutt
ln -s ~/.dotfiles/mail/msmtp ~/.config/msmtp
ln -s ~/.dotfiles/mail/mbsyncrc ~/.mbsyncrc
echo "*/30 * * * * /home/yigit/.scripts/mailsync" >> /var/spool/cron/yigit

# Root
sudo cp ~/.dotfiles/root/dwm.desktop /usr/share/xsessions
sudo cp ~/.dotfiles/root/nancyj.flf /usr/share/figlet/fonts

# Config
cp ~/.dotfiles/config.env.def ~/.config.env

# Install vim and tmux plugins
mkdir -p ~/.tmux/plugins
vim -c ':PlugInstall'
betterlockscreen -u ~/.dotfiles/backgrounds/lock.jpg
