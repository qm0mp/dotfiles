#!/bin/bash

username=$(whoami)

# Configuring for your username

if [ ! "$username" = "yigit" ]; then
  find /home/$username/.dotfiles -type f | xargs sed -i  "s/\/home\/yigit/\/home\/$username/g"
fi

# Install packages
echo "Running update"
sudo pacman --noconfirm -Syu
sudo pacman --noconfirm --needed -S $(cat ~/.dotfiles/arch-setup/nonAUR.txt)
yay -S --noconfirm --needed $(cat ~/.dotfiles/arch-setup/AUR.txt)

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
  ~/.dotfiles_backup 2> /dev/null > /dev/null

rsync --remove-source-files -avzh --ignore-errors \
  ~/.config/htop \
  ~/.config/.profile \
  ~/.config/.nvim \
  ~/.config/systemd \
  ~/.config/termite \
  ~/.config/zathura \
  ~/.config/dunst \
  ~/.config/gtk-4.0 \
  ~/.config/gtk-3.0 \
  ~/.config/gtk-2.0 \
  ~/.config/antibody \
  ~/.config/suckless \
  ~/.config/neofetch \
  ~/.dotfiles_backup/.config 2> /dev/null > /dev/null

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
  ~/.config/neofetch \
  ~/.config/dunst \
  ~/.config/gtk-4.0 \
  ~/.config/gtk-3.0 \
  ~/.config/gtk-2.0 \
  ~/.config/antibody \
  ~/.config/suckless

# Vim
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
ln -s ~/.dotfiles/vim/vim ~/.vim
ln -s ~/.dotfiles/vim/nvim ~/.config/nvim

# GTK
ln -s ~/.dotfiles/theming/themes ~/.themes
ln -s ~/.dotfiles/theming/qt5ct ~/.config/qt5ct
ln -s ~/.dotfiles/theming/gtkrc-2.0 ~/.gtkrc-2.0
ln -s ~/.dotfiles/theming/gtk-3.0 ~/.config/gtk-2.0
ln -s ~/.dotfiles/theming/gtk-3.0 ~/.config/gtk-3.0
ln -s ~/.dotfiles/theming/gtk-4.0 ~/.config/gtk-4.0
~/.dotfiles/theming/Tela-icon-theme/install.sh

# Miscellaneous
ln -s ~/.dotfiles/misc/dunst ~/.config/dunst
ln -s ~/.dotfiles/misc/zathura ~/.config/zathura
ln -s ~/.dotfiles/misc/termite/ ~/.config/termite
ln -s ~/.dotfiles/misc/vdirsyncer ~/.vdirsyncer
ln -s ~/.dotfiles/misc/systemd ~/.config/systemd
ln -s ~/.dotfiles/misc/ranger ~/.config/ranger
ln -s ~/.dotfiles/misc/neofetch ~/.config/neofetch
ln -s ~/.dotfiles/misc/profile ~/.config/.profile
ln -s ~/.dotfiles/misc/htop ~/.config/htop
ln -s ~/.dotfiles/misc/.fzf.zsh ~/.fzf.zsh
ln -s ~/.dotfiles/misc/keyboard ~/.keyboard
ln -s ~/.dotfiles/misc/mimeapps.list ~/.config/mimeapps.list
ln -s ~/.dotfiles/misc/wakatime.cfg ~/.wakatime.cfg
ln -s ~/.dotfiles/misc/BetterDiscord ~/.config/BetterDiscord
ln -s ~/.dotfiles/misc/nextcloud ~/.nextcloud
ln -s ~/.dotfiles/misc/calcurse ~/.calcurse
mkdir -p ~/.config/spotifyd
ln -s ~/.dotfiles/misc/spotifyd.conf ~/.config/spotifyd/spotifyd.conf
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
yay --noconfirm -S xsel clipnotify
yay --noconfirm -S ttf-symbola
(cd ~/.dotfiles/suckless; ~/.dotfiles/suckless/build.sh)

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
ln -s ~/.dotfiles/zsh/profile ~/.profile

# Mail
ln -s ~/.dotfiles/mail/mutt ~/.config/mutt
ln -s ~/.dotfiles/mail/msmtp ~/.config/msmtp
ln -s ~/.dotfiles/mail/mbsyncrc ~/.mbsyncrc
if [ ! -f "/var/spool/cron$username" ]; then
  sudo touch "/var/spool/cron/$username"
  sudo chown yigit:yigit "/var/spool/cron/$username"
  sudo chmod 755 "/var/spool/cron/$username"
fi
echo "COMMAND brave" > ~/.urlview
echo "*/8 * * * * /home/$username/.scripts/mailsync" >> /var/spool/cron/yigit
echo "*/15 * * * * /home/$username/.scripts/nextcloud-sync" >> /var/spool/cron/yigit
echo "*/30 * * * * calcurse-caldav" >> /var/spool/cron/yigit
echo "*/30 * * * * vdirsyncer sync" >> /var/spool/cron/yigit

# Root
sudo cp ~/.dotfiles/root/dwm.desktop /usr/share/xsessions
sudo cp ~/.dotfiles/root/nancyj.flf /usr/share/figlet/fonts
sudo cp ~/.dotfiles/root/quark.service /usr/lib/systemd/system
sudo cp ~/.dotfiles/root/kdialog /usr/local/bin/kdialog
sudo chmod +x /usr/local/bin/kdialog
sudo systemctl daemon-reload
sudo systemctl enable quark

# Config
cp ~/.dotfiles/config.env.def ~/.config.env

# Firefox
firefox-developer-edition -CreateProfile "yeet"
cp -r ~/.dotfiles/browser/flyingfox/* ~/.mozilla/firefox/*.yeet
cp -r ~/.dotfiles/browser/extensions ~/.mozilla/firefox/*.yeet
cp ~/.dotfiles/browser/extensions.json ~/.mozilla/firefox/*.yeet

# Start page

prev=$(pwd)
cd ~/.dotfiles/browser/startpage
npm install
npm run build
cd $prev
~/.dotfiles/arch-setup/fetch_keys.sh # Fetch keys (For personal use, this is not for you)

# Install vim and tmux plugins
mkdir -p ~/.tmux/plugins
vim -c ':PlugInstall'
betterlockscreen -u ~/.dotfiles/backgrounds/lock.jpg

# Install mconnect
git clone https://github.com/theFr1nge/mconnect.git /tmp/mconnect
prev=$(pwd)
cd /tmp/mconnect
mkdir -p build
cd build
meson ..
ninja
sudo ninja install
cd $prev
mkdir -p ~/Downloads/mconnect

sudo git clone https://github.com/theFr1nge/bitwarden-dmenu.git /usr/share/bwdmenu
cd /usr/share/bwdmenu
sudo npm install
sudo npm i -g
cd $prev

# Install simcrop
sudo pacman --needed --noconfirm -S opencv
git clone https://github.com/theFr1nge/simcrop.git /tmp/simcrop
cd /tmp/simcrop
sudo make install
cd $prev
