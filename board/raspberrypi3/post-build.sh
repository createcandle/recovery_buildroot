#!/bin/sh

set -u
set -e

echo "TARGET DIR: $TARGET_DIR" 

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:-/usr/bin/bash' ${TARGET_DIR}/etc/inittab
#tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

# make bash the initial login shell
#sed -i 's|bin/sh|/usr/bin/bash|' "${TARGET_DIR}/etc/passwd"
#if [ -e ${TARGET_DIR}/bin/ro-root.sh ]; then
#    echo "making bin/ro-root.sh executable"
#    chmod +x "$TARGET_DIR/bin/ro-root.sh" 
#else
#    echo "Error, yikes, bin/ro-root.sh not found" 
#fi

cp package/busybox/S10mdev ${TARGET_DIR}/etc/init.d/S10mdev
chmod 755 ${TARGET_DIR}/etc/init.d/S10mdev
cp package/busybox/mdev.conf ${TARGET_DIR}/etc/mdev.conf

chmod +x ${TARGET_DIR}/etc/rc.local

mkdir -p ${TARGET_DIR}/mnt/userpart
mkdir -p ${TARGET_DIR}/mnt/systempart
mkdir -p ${TARGET_DIR}/mnt/ramdrive

# don't auto-start SSHD
#rm ${TARGET_DIR}/etc/init.d/S50sshd


#cd ${TARGET_DIR}/lib/modules
#ln -s 5.10.92-v8/ 5.15.84-v8+
#cd -
#mv ${TARGET_DIR}/lib/modules/5.10.92-v8 ${TARGET_DIR}/lib/modules/5.15.84-v8+
#rm -rf ${TARGET_DIR}/lib/modules/5.10*

# already done in overlay? Github doesn't allow links, so probably not
#cd ${TARGET_DIR}/etc/init.d
#ln -s ../rc.local rc_local
