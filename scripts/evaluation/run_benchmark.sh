#!/bin/bash

# Inside the benchmark perf is called which needs to be executed with privileges for full info.


daphne_dir=$1
eval_dir=$(pwd)
# for branch in "accumulator" "loop_inversion" "tiling" "bond_tiling" #"affine_tiling_from_inverted"
# do 
#     cd "$daphne_dir" || exit
#     git checkout "benchmark/${branch}"
#     ./build.sh
    
#     cd "$eval_dir" || exit
#     ./scripts/evaluation/run_matmul_comp_machine.sh ${branch} "$daphne_dir"
# done

# cd "$daphne_dir" || exit
# git checkout "benchmark/${branch}"
# ./build.sh
cd "$eval_dir" || exit

# Assume matmul lowering configurations are given linewise in configurations.txt file.
# Each line looks like  name:--matmul-tile
configs="$HOME/lde_project/configurations/configurations.txt"
while read config
do 
    ./scripts/evaluation/run_matmul_comp_machine.sh "${config%%:*}" "$daphne_dir" "${config#*:}"
done < "$configs"

# The comparison benchmark
./scripts/evaluation/run_matmul_comp_machine_kernel.sh "$daphne_dir"

./scripts/evaluation/run_variable_sizes.sh "$daphne_dir" "${config%%:*}" "${config#*:}"

# Single Precision
single_configs="$HOME/lde_project/configurations/single_configurations.txt"
while read sconfig
do 
    ./scripts/evaluation/run_matmul_single_comp_machine.sh "${sconfig%%:*}" "$daphne_dir" "${sconfig#*:}"
done < "$single_configs"

# Dump assembly code
cd "$daphne_dir" || exit
git apply < "$eval_dir"/scripts/git_patches/dump.patch
./build.sh

cd "$eval_dir" || exit
"$daphne_dir"/bin/daphne --mlir-codegen $3 ./scripts/matmul/matmul2048.daph