# Apptainer-ception

This repository provides a tool to build [Apptainer](https://apptainer.org/) containers on [NeSI](https://www.nesi.org.nz).

This code is experimental, unsupported, subject to change, provided **without any guarantee** that it will not eat your data and your cookies.


## Usage

Log in Mahuika via SSH, then clone this repository:

```bash
git clone https://github.com/jennan/apptainerception.git
```

Make sure to have a build directory and a cache directory for Apptainer, for example:

```bash
export APPTAINER_CACHEDIR=/nesi/nobackup/PROJECT_ID/apptainer_cachedir
export APPTAINER_TMPDIR=/nesi/nobackup/PROJECT_ID/apptainer_tmpdir
mkdir -p "$APPTAINER_CACHEDIR" "$APPTAINER_TMPDIR"
```

where `PROJECT_ID` is your NeSI project number.

Run the builder script on a Mahuika extension node, for example:

```bash
srun -p milan --time 0-00:30:00 --mem 4GB --cpus-per-task 2 builder.bash my_container.sif my_container.def
```


## Explanation

This script behaves like the `apptainer build` command.
It is actually wrapping an Apptainer container containing the `apptainer` tool, hence it's an apptainer-ception ;-).

The key to making `apptainer build` work inside apptainer is to unset the `APPTAINER_BIND` variable before calling `apptainer build` inside the container.
Otherwise, it will fail when trying to mount the folders, with an error message saying that they do not exist.

The rest of the script ensures that the right modules are loaded on NeSI and the usual folders are defined as bind paths.


## Troubleshooting

If running the builder script results in an authentication error about ghcr.io, for example

```
error="failed to authorize: failed to fetch oauth token: unexpected status: 403 Forbidden" host=ghcr.io
```

try to log out of oras://ghcr.io before retrying

```bash
apptainer remote logout oras://ghcr.io
```


## TODO

- check if `--no-home` is really needed to avoid the dummy `.bashrc`
- add bindings to typical NeSI folders (project, nobackup, etc.)
