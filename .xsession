xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/kbd $DISPLAY

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

export GDK_DPI_SCALE=1.25

exec i3
