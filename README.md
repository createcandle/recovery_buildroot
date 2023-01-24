# Candle Recovery partition buildroot

Used to create the Candle recovery partition.

See also https://github.com/createcandle/recovery_overlay

- place recovery_overlay files so it becomes buildroot/rootfs_overlay/etc
- increment buildroot/rootfs_overlay/candle_recovery.txt, which contains the version number
- rename config file to .config. It should become buildroot/.config


- check settings with `make menuconfig`
- run `make`


- generated files can be checked in output/target
- run `prepare_recovery.sh` to generate final files in output/images

- run `make clean` to reset everything
