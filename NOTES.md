# Notes

- make sure to be on a Milan node
- get an working image with apptainer installed it
- load modules

```
. /etc/bashrc  # to get modules working
module purge && module load Apptainer/1.0.3
module unload Xalt
```

- get your APPTAINER_TMPDIR and APPTAINER_CACHEDIR configured (not sure it is needed)
- execute the build, ensuring the APPTAINER_BIND variable is not inherited

```
apptainer exec -B $(pwd) ubuntu_apptainer.sif \
    bash -c "APPTAINER_BIND='' apptainer build image.sif image.def"
```
 
