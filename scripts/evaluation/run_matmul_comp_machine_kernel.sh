#!/bin/bash

daphne_dir=$1
cmmand="$daphne_dir/bin/daphne ./scripts/matmul/matmul2048.daph >> ./scripts/outputs_machine/kernel.out"
hyperfine -w=3 --export-json "./scripts/outputs_machine/kernel.json" --output "pipe" "$cmmand"

perf stat -B -e cache-references,cache-misses,cycles,instructions,branches,faults,migrations "$daphne_dir"/bin/daphne ./scripts/matmul/matmul2048.daph &>> "./scripts/outputs_machine/kernel.txt"
