# Notes

- make sure to be on a Milan node
- load modules

```bash
. /etc/bashrc  # to get modules working
module purge && module load Apptainer/1.0.3
module unload Xalt
```

- get your APPTAINER_TMPDIR and APPTAINER_CACHEDIR configured

```
export APPTAINERENV_APPTAINER_CACHEDIR="$APPTAINER_CACHEDIR"
export APPTAINERENV_APPTAINER_TMPDIR="$APPTAINER_TMPDIR"
export APPTAINER_BINDPATH="$APPTAINER_TMPDIR,$APPTAINER_CACHEDIR"
```

- run the builder image in the image folder

```bash
apptainer run --no-home -B $(pwd) ubuntu_apptainer.sif image.sif image.def
```

The `--no-home` option avoid a dummy `.bash_history` to be created in the local folder.
