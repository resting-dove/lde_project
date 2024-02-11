#!/bin/bash

# Execution times are gathered for single precision matmul.
# The individual outputs are written -> .singleout
# Inputs:
#   $1: The name for the run
#   $2: The daphne directory, like ~/daphne
#   $3: The daphne configuration in extension of --mlir-codegen, like "--matmul-tile --matmul-unroll-factor=2"

daphne_dir=$2
# $3 is the advanced configuration if specified. Expect smth like "--matmul-tile --explain=mlir-codegen".
# Thus we explicitly want word splitting to happen --> $3 not "$3"

cmmand="$daphne_dir/bin/daphne --mlir-codegen $3 ./scripts/matmul/matmul2048_single.daph >> ./scripts/outputs_machine/$1.singleout"
hyperfine -w=3 --output "pipe" "$cmmand"
