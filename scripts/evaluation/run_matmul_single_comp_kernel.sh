#!/bin/bash

# Execution times are gathered for single precision matmul.
# The individual outputs are written -> kernel.singleout
# Inputs:
#   $1: The daphne directory, like ~/daphne

daphne_dir=$1

cmmand="$daphne_dir/bin/daphne ./scripts/matmul/matmul2048_single.daph >> ./scripts/outputs_machine/kernel.singleout"
hyperfine -w=3 --output "pipe" "$cmmand"
