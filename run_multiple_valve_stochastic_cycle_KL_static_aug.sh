#! /bin/bash


for i in `seq 2`
do
    docker run --rm --gpus all --privileged --net=host --ipc=host \
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
    docker_cdsvae python3.8 usecase/train/train.py \
    --config-name=config_cdsvae_valve_stochastic_cycle_KL_single_positive \
    datamodule.sub_name=static_aug
done
