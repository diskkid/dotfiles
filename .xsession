xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/kbd $DISPLAY
xset r rate 200 30

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

export GDK_DPI_SCALE=1.25

export PATH="$HOME/.local/bin:$PATH"

exec i3
