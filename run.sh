docker run --rm -it \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY -h $HOSTNAME \
    -v $HOME/.Xauthority:/home/jumble/.Xauthority \
    -v $PWD/notes.db:/home/jumble/notes/notes.db \
    -u jumble \
    --name notes \
    notes