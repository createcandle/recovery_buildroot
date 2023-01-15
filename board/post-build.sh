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
if [ -e ${TARGET_DIR}/bin/ro-root.sh ]; then
    echo "making bin/ro-root.sh executable"
    chmod +x "$TARGET_DIR/bin/ro-root.sh" 
else
    echo "Error, yikes, bin/ro-root.sh not found" 
fi
