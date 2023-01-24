#!/bin/bash

# turns recovery rootfs partition into tarred file and its checksum

export GZIP=-9 #maximum strength

if [ ! -f output/images/rootfs.ext2 ];
then
echo "Error, no rootfs.ext2 found. Aborting" 
exit 1
fi

echo "creating recovery.fs.tar.gz"

cd output/images

if [ -f recovery.fs ]; then
    rm recovery.fs
fi
if [ -f recovery.fs.tar.gz ]; then
    rm recovery.fs.tar.gz
fi

mv rootfs.ext2 recovery.fs
tar czf recovery.fs.tar.gz recovery.fs

md5sum recovery.fs.tar.gz | awk '{print $1}'
md5sum recovery.fs.tar.gz | awk '{print $1}' | tr -d \\n > recovery.fs.tar.gz.checksum
echo "done"
