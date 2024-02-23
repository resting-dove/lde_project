#!/bin/bash

# Execution times are gathered for integer matmul.
# The individual outputs are written -> kernel.intout
# Inputs:
#   $1: The daphne directory, like ~/daphne

daphne_dir=$1

cmmand="$daphne_dir/bin/daphne ./scripts/matmul/matmul2048_int.daph >> ./scripts/outputs_machine/kernel.intout"
hyperfine --runs=3 --output "pipe" "$cmmand"
