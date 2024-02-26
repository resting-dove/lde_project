#!/bin/bash

daphne_dir=$1
eval_dir=$(pwd)

cd "$daphne_dir" || exit
git checkout "submission"
# Set Optimization level to 3
git apply < "$eval_dir"/scripts/git_patches/optLevel3.patch
git apply < "$eval_dir"/scripts/git_patches/build.patch
./build.sh
cd "$eval_dir" || exit

for size in "2048" "4096" "8192" "12288"
do
    for i in 1 2 3
    do
        sed "s/SIZE/$size/g" ./scripts/matmul/matmulTemplate.daph > ./tmp.daph   
        configs="$HOME/lde_project/configurations/server_configurations.txt"
        while read config
        do 
            name="${config%%:*}"
            config="${config#*:}"
            touch ./scripts/outputs/"${name}"_server.out
            echo $size >> ./scripts/outputs/"${name}"_server.out
            "$daphne_dir/bin/daphne" --mlir-codegen $config "./tmp.daph" >> "./scripts/outputs/${name}_server.out"
            
        done < "$configs"
        touch ./scripts/outputs/kernel_server.out
        echo $size >> ./scripts/outputs/kernel_server.out
        "$daphne_dir/bin/daphne" "./tmp.daph" >> "./scripts/outputs/kernel_server.out"
        rm ./tmp.daph
    done
done


