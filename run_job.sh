#!/bin/bash

source /home/z5211173/.venvs/Complex-YOLO/bin/activate

cd /home/z5211173/Complex-YOLO

mkdir $TMPDIR/KITTI 

wget --no-check-certificate https://s3.eu-central-1.amazonaws.com/avg-kitti/data_object_calib.zip -P $TMPDIR/KITTI/
wget --no-check-certificate https://s3.eu-central-1.amazonaws.com/avg-kitti/data_object_velodyne.zip -P $TMPDIR/KITTI/
wget --no-check-certificate https://s3.eu-central-1.amazonaws.com/avg-kitti/data_object_label_2.zip -P $TMPDIR/KITTI/

unzip $TMPDIR/KITTI/data_object_calib.zip -d $TMPDIR/KITTI/
unzip $TMPDIR/KITTI/data_object_label_2.zip -d $TMPDIR/KITTI/
unzip $TMPDIR/KITTI/data_object_velodyne.zip -d $TMPDIR/KITTI/

mv /home/z5211173/Complex_YOLO/train.txt $TMPDIR/KITTI/training/train.txt

a=$(echo $TMPDIR)
sed -i "s,\$TMPDIR,$a,g" main.py
sed -i "s,\$TMPDIR,$a,g" eval.py 
sed -i "s,\$TMPDIR,$a,g" kitti.py 

python3 main.py

python3 eval.py