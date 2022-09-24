#!/usr/bin/env bash

# to get modules working on Milan nodes
. /etc/bashrc 

# exit on errors, undefined variables and errors in pipes
set -euo pipefail

# get Apptainer module working
module purge 2>/dev/null
module load Apptainer/1.0.3
module unload XALT

# ensure cache and buildir are defined and passed to the builder container
if [ -z "${APPTAINER_CACHEDIR:-}" ]; then
    echo "Set APPTAINER_CACHEDIR as your cache directory before running this script."
    exit 1
fi

if [ -z "${APPTAINER_TMPDIR:-}" ]; then
    echo "Set APPTAINER_TMPDIR as your build directory before running this script."
    exit 1
fi

export APPTAINERENV_APPTAINER_CACHEDIR="$APPTAINER_CACHEDIR"
export APPTAINERENV_APPTAINER_TMPDIR="$APPTAINER_TMPDIR"
export APPTAINER_BINDPATH="${APPTAINER_BINDPATH:-},$APPTAINER_TMPDIR,$APPTAINER_CACHEDIR"

# pass all parameters to the builder container
apptainer run --no-home -B $(pwd) builder.sif $*
