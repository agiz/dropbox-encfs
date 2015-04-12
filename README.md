# Dropbox - encfs

Guide and scripts to set up encrypted filesystem on dropbox.

## Prerequisites

0. fuse
1. encfs
2. dropbox client and binary daemon

## Set up encfs

0. Compile from source or install from repository.
1. Create folder for unencrypted files `mkdir -p /mnt/share/Private`
2. Create folder for encrypted files `mkdir -p /mnt/share/Dropbox/Encrypted`
3. Run encfs for the first time, choose your level of encryption (or just hit enter),
choose password and run `encfs /mnt/share/Dropbox/Encrypted /mnt/share/Private`
4. Move .encfs6.xml: `mv /mnt/share/Dropbox/Encrypted/.encfs6.xml ~/`
5. Add to `sudo visudo`: `Defaults env_keep += "ENCFS6_CONFIG"` (after `Defaults env_reset`).

## Compiling dropbox from source

0. libnautilus-extension-dev is needed
1. `curl -L -O https://linux.dropbox.com/packages/nautilus-dropbox-1.6.1.tar.bz2.gz`
2. `tar xjf ./nautilus-dropbox-1.6.1.tar.bz2`
3. `cd ./nautilus-dropbox-1.6.1`
4. `./configure`
5. `make`
6. You do not need to install with `make install` if you do not wish to.

## Soft-segregate dropbox from the rest of the system (Optional, but recommended)

1. Create user: `adduser dropbox`
2. Change to dropbox user: `su dropbox`
3. Copy dropbox to it's own home: `mv ./nautilus-dropbox-1.6.1 /home/dropbox/`
4. Create symbolic link: `ln -s /home/dropbox/nautilus-dropbox-x.x.x dropbox-current`
5. Copy `dropbox-cron.sh` to it's own home `mv ./dropbox-cron.sh /home/dropbox/`
6. Add periodic sync of encrypted folder with dropbox to cron: `crontab -e`
7. Add: `35   5    *   *   * /home/dropbox/dropbox-cron.sh >/dev/null 2>&1`. This
command will execute at 5:35am every day.
8. Cron timings are explained at http://www.cronchecker.net
9. Soft link Dropbox folder: `ln -s /mnt/share/Dropbox ~/Dropbox` 
10. Run `./nautilus-dropbox-1.6.1/dropbox start -i` to install binary daemon.
11. Link computer: `killall dropbox`, Run `dropboxd` manually (as dropbox user)
`~/.dropbox-dist/drpoboxd` and follow the link.
12. Stop dropboxd either `Ctrl+C` or `killall dropboxd`.

## Usage

Script `mount_encfs.sh` mounts file system. Script `dropbox-cron.sh` is run
periodically every day. Unmount encrypted share with `sudo fusermount -u /mnt/share/Private`.

## Credits

agiz

## License

TODO: Write license
