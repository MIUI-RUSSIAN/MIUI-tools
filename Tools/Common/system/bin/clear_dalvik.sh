#!/system/bin/sh
    echo "monte /sd-ext";
    mount -t auto /dev/block/mmcblk0p2 /data;
    rm -rf /data/dalvik-cache/*;
    echo "demonte /sd-ext";
    umount /data;
    echo "monte /data";
    mount /dev/block/mtdblock5 /data;
    rm -rf /data/dalvik-cache/*;
    echo "demonte /data";
    umount /data;
exit 0;