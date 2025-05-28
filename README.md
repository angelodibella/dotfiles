# Installation

To clean install (override) the configurations follow these steps.

1. Clone this repository's desired branch:

    ```bash
    git clone -b <branch> https://github.com/angelodibella/dotfiles ~/Dotfiles
    cd ~/Dotfiles
    ```

2. For each folder inside `Dotfiles/` inspect the directory structure:

    ```bash
    tree -da <folder>
    ```

    now make the directory structure, making sure to delete previous objects in the path:

    ```bash
    rm -rf /path/to/config/
    mkdir -p /directory/structure/
    ```

3. Finally, stow each component in `Dotfiles/`:
 
    ```bash
    stow <component>
    ```

# Further Steps

Follow these steps to make sure everything works as expected.

**Note:** These are not exhaustive! However, they are the trickiest steps I've found.

## Zsh Augmentation

Run the following to clone useful libraries in `.zsh/`:
```bash
cd ~/.zsh
git clone https://github.com/romkatv/powerlevel10k.git
git clone https://github.com/zsh-users/zsh-autosuggestions.git
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/junegunn/fzf-git.sh.git
```

## Catppuccin Icons and Cursors

Install the (deprecated) GTK 3/4 Catppuccin themes with `yay -S catppuccin-gtk-theme-mocha`. Next, install the papirus icon theme via

```bash
yay -S papirus-icon-theme
```

and make it Catppuccin-themed by installing

```bash
yay -S papirus-folders-catppuccin-git
```

and running

```bash
papirus-folders -C cat-mocha-flamingo --theme Papirus-Dark
```
For the cursors, run

```bash
yay -S catppuccin-cursors-mocha
```

Now, using `nwg-look`, select the desired configurations. Install this `yay -S nwg-look`.

## Rclone `systemd` Mount

We assume mounting Google Drive and OneDrive to the `/mnt` directory. To do this, first install rclone via

```bash
yay -S rclone
```

then run, separately,

```bash
rclone lsd gdrive:
```

```bash
rclone lsd onedrive:
```

If the output is positive, continue. Otherwise, the configuration needs fixing.

Start by creating the mountpoints on `/mnt`:

```bash
cd /mnt
sudo mkdir gdrive onedrive
sudo chown angelo gdrive
sudo chown angelo onedrive
```

Then, create and edit `/etc/systemd/user/rclone@.service` to include the following:

```ini
[Unit]
Description=RClone mount of users remote %i using filesystem permissions
Documentation=http://rclone.org/docs/
After=network-online.target


[Service]
Type=notify
#Set up environment
Environment=REMOTE_NAME="%i"
Environment=REMOTE_PATH="/"
Environment=MOUNT_DIR="/mnt/%i"
Environment=POST_MOUNT_SCRIPT=""
Environment=RCLONE_CONF="%h/.config/rclone/rclone.conf"
Environment=RCLONE_TEMP_DIR="/tmp/rclone/%u/%i"
Environment=RCLONE_RC_ON="false"

#Default arguments for rclone mount. Can be overridden in the environment file
Environment=RCLONE_MOUNT_ATTR_TIMEOUT="1s"
#TODO: figure out default for the following parameter
Environment=RCLONE_MOUNT_DAEMON_TIMEOUT="UNKNOWN_DEFAULT"
Environment=RCLONE_MOUNT_DIR_CACHE_TIME="60m"
Environment=RCLONE_MOUNT_DIR_PERMS="0777"
Environment=RCLONE_MOUNT_FILE_PERMS="0666"
Environment=RCLONE_MOUNT_GID="%G"
Environment=RCLONE_MOUNT_MAX_READ_AHEAD="128k"
Environment=RCLONE_MOUNT_POLL_INTERVAL="1m0s"
Environment=RCLONE_MOUNT_UID="%U"
Environment=RCLONE_MOUNT_UMASK="022"
Environment=RCLONE_MOUNT_VFS_CACHE_MAX_AGE="1h0m0s"
Environment=RCLONE_MOUNT_VFS_CACHE_MAX_SIZE="off"
Environment=RCLONE_MOUNT_VFS_CACHE_MODE="off"
Environment=RCLONE_MOUNT_VFS_CACHE_POLL_INTERVAL="1m0s"
Environment=RCLONE_MOUNT_VFS_READ_CHUNK_SIZE="128M"
Environment=RCLONE_MOUNT_VFS_READ_CHUNK_SIZE_LIMIT="off"
#TODO: figure out default for the following parameter
Environment=RCLONE_MOUNT_VOLNAME="UNKNOWN_DEFAULT"

#Overwrite default environment settings with settings from the file if present
EnvironmentFile=-%h/.config/rclone/%i.env

#Check that rclone is installed
ExecStartPre=/usr/bin/test -x /usr/bin/rclone

#Check the mount directory
ExecStartPre=/usr/bin/test -d "${MOUNT_DIR}"
ExecStartPre=/usr/bin/test -w "${MOUNT_DIR}"
#TODO: Add test for MOUNT_DIR being empty -> ExecStartPre=/usr/bin/test -z "$(ls -A "${MOUNT_DIR}")"

#Check the rclone configuration file
ExecStartPre=/usr/bin/test -f "${RCLONE_CONF}"
ExecStartPre=/usr/bin/test -r "${RCLONE_CONF}"
#TODO: add test that the remote is configured for the rclone configuration

#Mount rclone fs
ExecStart=/usr/bin/rclone mount \
            --config="${RCLONE_CONF}" \
#See additional items for access control below for information about the following 2 flags
#            --allow-other \
#            --default-permissions \
            --rc="${RCLONE_RC_ON}" \
            --cache-tmp-upload-path="${RCLONE_TEMP_DIR}/upload" \
            --cache-chunk-path="${RCLONE_TEMP_DIR}/chunks" \
            --cache-workers=8 \
            --cache-writes \
            --cache-dir="${RCLONE_TEMP_DIR}/vfs" \
            --cache-db-path="${RCLONE_TEMP_DIR}/db" \
            --no-modtime \
            --drive-use-trash \
            --stats=0 \
            --checkers=16 \
            --bwlimit=40M \
            --cache-info-age=60m \
            --attr-timeout="${RCLONE_MOUNT_ATTR_TIMEOUT}" \
#TODO: Include this once a proper default value is determined
#           --daemon-timeout="${RCLONE_MOUNT_DAEMON_TIMEOUT}" \
            --dir-cache-time="${RCLONE_MOUNT_DIR_CACHE_TIME}" \
            --dir-perms="${RCLONE_MOUNT_DIR_PERMS}" \
            --file-perms="${RCLONE_MOUNT_FILE_PERMS}" \
            --gid="${RCLONE_MOUNT_GID}" \
            --max-read-ahead="${RCLONE_MOUNT_MAX_READ_AHEAD}" \
            --poll-interval="${RCLONE_MOUNT_POLL_INTERVAL}" \
            --uid="${RCLONE_MOUNT_UID}" \
            --umask="${RCLONE_MOUNT_UMASK}" \
            --vfs-cache-max-age="${RCLONE_MOUNT_VFS_CACHE_MAX_AGE}" \
            --vfs-cache-max-size="${RCLONE_MOUNT_VFS_CACHE_MAX_SIZE}" \
            --vfs-cache-mode="${RCLONE_MOUNT_VFS_CACHE_MODE}" \
            --vfs-cache-poll-interval="${RCLONE_MOUNT_VFS_CACHE_POLL_INTERVAL}" \
            --vfs-read-chunk-size="${RCLONE_MOUNT_VFS_READ_CHUNK_SIZE}" \
            --vfs-read-chunk-size-limit="${RCLONE_MOUNT_VFS_READ_CHUNK_SIZE_LIMIT}" \
#TODO: Include this once a proper default value is determined
#            --volname="${RCLONE_MOUNT_VOLNAME}"
            "${REMOTE_NAME}:${REMOTE_PATH}" "${MOUNT_DIR}"

#Execute Post Mount Script if specified
ExecStartPost=/bin/sh -c "${POST_MOUNT_SCRIPT}"

#Unmount rclone fs
ExecStop=/bin/fusermount3 -u "${MOUNT_DIR}"

#Restart info
Restart=always
RestartSec=10

[Install]
WantedBy=default.target
```

Then run `systemctl --user daemon-reload` to load this unit. Next, activate the services:

```bash
systemctl --user start rclone@gdrive
systemctl --user start rclone@onedrive
```

Check if these are loaded correctly in `/mnt`, then enable them:

```bash
systemctl --user enable rclone@gdrive
systemctl --user enable rclone@onedrive
```

More information available at https://github.com/rclone/rclone/wiki/Systemd-rclone-mount/.

### Mount Symlinks

What I like to do is create symlinks of these drives to my home directory. This can by done by running

```bash
cd ~
ln -s /mnt/gdrive Google\ Drive
ln -s /mnt/onedrive OneDrive
```

and for some of the folders too (ensure they are deleted first):

```bash
cd ~
ln -s /mnt/onedrive/Desktop Desktop
ln -s /mnt/onedrive/Documents Documents
ln -s /mnt/onedrive/Picture Picture
ln -s /mnt/onedrive/Music Music
```