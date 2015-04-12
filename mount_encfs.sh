#!/bin/sh

# pass:
# hidden

# first add ENCFS6_CONFIG to visudo env_keep (after Defaults env_reset)
# sudo visudo
# Defaults env_keep += "ENCFS6_CONFIG"

# mount encrypted volume
export ENCFS6_CONFIG=/home/administrator/.encfs6.xml && sudo encfs /mnt/share/Dropbox/Encrypted /mnt/share/Private -o allow_other,uid=1001,gid=1002

# umount encrypted volume
echo "to unmount:"
echo "sudo fusermount -u /mnt/share/Private"
