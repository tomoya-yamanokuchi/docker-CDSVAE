#! /bin/bash


for i in `seq 4`
do
    docker run --rm --gpus all --privileged --net=host --ipc=host \
    -e LOCAL_UID=$(id -u $USER) \
    -e LOCAL_GID=$(id -g $USER) \
    -v $HOME/.Xauthority:/home/$(id -un)/.Xauthority -e XAUTHORITY=/home/$(id -un)/.Xauthority \
    -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY \
    -v /dev/snd:/dev/snd -e AUDIODEV="hw:Device, 0" \
    -v /nfs/workspace/C-DSVAE:/nfs/workspace/C-DSVAE \
    -v /nfs/workspace/Controllable-C-DSVAE:/nfs/workspace/Controllable-C-DSVAE \
    -v /nfs/workspace/Contrastively-Disentangled-Sequential-Variational-Audoencoder:/nfs/workspace/Contrastively-Disentangled-Sequential-Variational-Audoencoder \
    -v /nfs/workspace/dataset:/nfs/workspace/dataset \
    -v /nfs/logs_cdsvae:/nfs/logs_cdsvae \
    docker_cdsvae /usr/bin/python3.8 /nfs/workspace/C-DSVAE/usecase/train/train.py \
    --config-name=config_cdsvae_valve_stochastic_keyframe_action_sensor_content_estimation
done
