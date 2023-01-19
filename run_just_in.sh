#! /bin/bash

# rm:         コンテナ終了時に自動的にコンテナを削除
# it:         -i + -t: 標準入力とTerminalをAttachする
# gpus:       all, または 0, 1, 2
# privileged: ホストと同じレベルでのアクセス許可
# net=host:   ホストとネットワーク名前空間を共有
# ipc=host:   ホストとメモリ共有

docker run --rm -it --gpus all --privileged --net=host --ipc=host \
-e LOCAL_UID=$(id -u $USER) \
-e LOCAL_GID=$(id -g $USER) \
-v $HOME/.Xauthority:/home/$(id -un)/.Xauthority -e XAUTHORITY=/home/$(id -un)/.Xauthority \
-v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY \
-v /dev/snd:/dev/snd -e AUDIODEV="hw:Device, 0" \
-v /home/$USER/workspace/C-DSVAE:/home/$USER/workspace/C-DSVAE \
-v /home/$USER/workspace/Controllable-C-DSVAE:/home/$USER/workspace/Controllable-C-DSVAE \
-v /home/$USER/workspace/Contrastively-Disentangled-Sequential-Variational-Audoencoder:/home/$USER/workspace/Contrastively-Disentangled-Sequential-Variational-Audoencoder \
-v /home/$USER/workspace/dataset:/home/$USER/workspace/dataset \
-v /hdd_mount/logs_cdsvae:/hdd_mount/logs_cdsvae \
docker_cdsvae bash