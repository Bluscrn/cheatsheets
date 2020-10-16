# rsync
### Basic example
```bash
# syncing folder src into dest:
rsync -avzP ./src /dest
# syncing the content of src into dest:
rsync -avzP ./src/ /dest
```

### My Exclusions

```bash
--exclude 'OneDrive/'
--exclude '*.iso'
--exclude 'business_onedrive/'
--exclude '2_onedrive/'
```

### Transfer options

```bash
-a, --archive   # archive mode; equals -rlptgoD (no -H,-A,-X)
  -r, --recursive # recurse into directories
  -l, --links     # copy symlinks as symlinks
  -t, --times     # preserve modification times
  -g, --group     # preserve group
  -o, --owner     # preserve owner (super-user only)
  -D  same as --devices --specials
    --devices     # preserve device files (super-user only)
    --specials    # preserve special files
-v, --verbose   # increase verbosity
-z, --compress
-P  same as --partial --progress
    --partial   # allows resuming of aborted syncs
    --progress  # show progress during transfer
```
```bash
-n, --dry-run
    --bwlimit=RATE    # limit socket I/O bandwidth
```
### Display options

```bash
-q, --quiet
    --stats
-h, --human-readable
    --progress
-P                     # same as --partial --progress
```

### Skipping options

```bash
-u, --update     # skip files newer on dest
-c, --checksum   # skip based on checksum, not mod-time & size
```

### Backup options

```bash
-b, --backup           # backup with suffix
    --suffix=SUFFIX    # default ~ without --backup-dir
    --backup-dir=DIR
```

### Include options

```bash
--exclude=PATTERN
--include=PATTERN
```

```bash
--exclude-from=FILE
--include-from=FILE
--files-from=FILE    # read list of filenames from FILE
```

```bash
-C, --cvs-exclude    # exclude from local/global .cvsignore
```

### Archive options

```bash
-a, --archive    # archive (-rlptgoD)
```

```bash
-r, --recursive
-l, --links      # copy symlinks as links
-p, --perms      # preserve permissions
-t, --times      # preserve times
-g, --group      # preserve group
-o, --owner      # preserve owner
-D               # --devices --specials
```

```bash
--delete         # Delete extra files
```
