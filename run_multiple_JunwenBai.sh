#! /bin/bash

for i in `seq 10`
do
    docker run --rm --gpus all --privileged --net=host --ipc=host \
    -e LOCAL_UID=$(id -u $USER) \
    -e LOCAL_GID=$(id -g $USER) \
    -v $HOME/.Xauthority:/home/$(id -un)/.Xauthority -e XAUTHORITY=/home/$(id -un)/.Xauthority \
    -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY \
    -v /dev/snd:/dev/snd -e AUDIODEV="hw:Device, 0" \
    -v /home/$USER/workspace/C-DSVAE:/home/$USER/workspace/C-DSVAE \
    -v /home/$USER/workspace/dataset:/home/$USER/workspace/dataset \
    -v /mnt/logs_cdsvae:/mnt/logs_cdsvae \
    docker_cdsvae python3.8 train_cdsvae.py \
       --gpu 0 \
       --nEpoch 100 \
       --log_dir logs \
       --lr 0.001 \
       --batch_size 128 \
       --weight_f 1 \
       --weight_z 1 \
       --weight_c_aug 10 \
       --weight_m_aug 10 \
       --sche const \
       --type_gt action \
       --note JunwenBai
done