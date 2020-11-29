docker run --rm -it \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY -h $HOSTNAME \
    -v $HOME/.Xauthority:/home/jumble/.Xauthority \
    -u jumble \
    --name notes \
    --env QT_DEBUG_PLUGINS=1 \
    notes