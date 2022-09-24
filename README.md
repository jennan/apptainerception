# Apptainer-ception


## Usage

- make sure to be on a Milan node
- load modules

```bash
. /etc/bashrc  # to get modules working
module purge && module load Apptainer/1.0.3
module unload Xalt
```

- pass your APPTAINER_TMPDIR and APPTAINER_CACHEDIR to the container

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


## Explanation

The key to making `apptainer build` work inside apptainer is to unset the `APPTAINER_BIND` variable before calling `apptainer build` inside the container.
Otherwise, it will fail when trying to mount the folders, with an error message saying that they do not exist.


## TODO

- update usage with `builder.bash`
  - add example of `srun` to milan node
  - explain how/why create `APPTAINER_CACHEDIR` and `APPTAINER_TMPDIR`
  - add mention to `APPTAINER_BINDPATH` for extra bindings
- put the repo on github
  - add CI to generate `builder.sif`
  - run directly from github package in `builder.bash` and rely on cache
  - add a mention that this repo is experimental / use it at your own risk / not supported
- check if `--no-home` is really needed to avoid the dummy `.bashrc`
- add bindings to typical NeSI folders (project, nobackup, etc.)
