#!/bin/bash

daphne_dir=$1
touch ./scripts/outputs/kernel_sizes.out
for size in "2048" "2047" "1024" "512" "256" "128"
do

echo $size >> ./scripts/outputs/kernel_sizes.matvec

for i in 1 2 3
do
sed "s/SIZE/$size/g" ./scripts/matmul/matvecTemplate.daph > ./tmp.daph
"$daphne_dir/bin/daphne" "./tmp.daph" >> "./scripts/outputs/kernel_sizes.matvec"
rm ./tmp.daph
done
done