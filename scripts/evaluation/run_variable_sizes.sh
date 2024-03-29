#!/bin/bash

daphne_dir=$1
#touch ./scripts/outputs/kernel_sizes.out
touch ./scripts/outputs/"${2}"_sizes.out
name=$2
config=$3
for size in "2048" "2047" "1024" "512" "256" "128" "4096" "8192" "12288"
do

#echo $size >> ./scripts/outputs/kernel_sizes.out
echo $size >> ./scripts/outputs/"${2}"_sizes.out

for i in 1 2 3
do
sed "s/SIZE/$size/g" ./scripts/matmul/matmulTemplate.daph > ./tmp.daph
#"$daphne_dir/bin/daphne" "./tmp.daph" >> "./scripts/outputs/kernel_sizes.out"
"$daphne_dir/bin/daphne" --mlir-codegen $3 "./tmp.daph" >> "./scripts/outputs/${2}_sizes.out"
rm ./tmp.daph
done
done