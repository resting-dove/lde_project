#!/bin/bash

# A suite of benchmarks are run.
# The output is checked for closeness with the kernel implementation -> .eq
# The individual outputs are written -> .out
# Run infos including query compile time are gathered -> .json
# Cache infos are gathered -> .perf
# Inputs:
#   $1: The name for the run
#   $2: The daphne directory, like ~/daphne
#   $3: The daphne configuration in extension of --mlir-codegen, like "--matmul-tile --matmul-unroll-factor=2"

daphne_dir=$2
# $3 is the advanced configuration if specified. Expect smth like "--matmul-tile --explain=mlir-codegen".
# Thus we explicitly want word splitting to happen --> $3 not "$3"

# Check for accuracy. Kernel is pretty fast but the writing and reading is slow. 
"$daphne_dir"/bin/daphne --mlir-codegen $3 ./scripts/matmul/print_matmul2048.daph >> "./scripts/outputs_machine/$1.matrix"
"$daphne_dir"/bin/daphne ./scripts/matmul/print_matmul2048.daph >> "./scripts/outputs_machine/kernel.matrix"
python3 "./scripts/python/compare_matrices.py" "./scripts/outputs_machine/$1.matrix" "./scripts/outputs_machine/kernel.matrix" > "./scripts/outputs_machine/$1.eq"
rm "./scripts/outputs_machine/$1.matrix"
rm "./scripts/outputs_machine/kernel.matrix"

cmmand="$daphne_dir/bin/daphne --mlir-codegen $3 ./scripts/matmul/matmul2048.daph >> ./scripts/outputs_machine/$1.out"
hyperfine -w=3 --export-json "./scripts/outputs_machine/$1.json" --output "pipe" "$cmmand"

perf stat -B -e cache-references,cache-misses,cycles,instructions,branches,faults,migrations "$daphne_dir"/bin/daphne --mlir-codegen $3 ./scripts/matmul/matmul2048.daph &>> "./scripts/outputs_machine/$1.perf"
