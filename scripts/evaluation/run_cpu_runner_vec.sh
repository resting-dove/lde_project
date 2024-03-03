#!/bin/bash

daphne_dir=$1
"$daphne_dir/thirdparty/installed/bin/mlir-opt" --affine-loop-invariant-code-motion --affine-scalrep -affine-data-copy-generate="generate-dma=false fast-mem-space=0 fast-mem-capacity=32" ./mlir_code/bond_vec_8192.mlir | "$daphne_dir/thirdparty/installed/bin/mlir-opt"  -pass-pipeline="builtin.module(func.func(convert-linalg-to-loops,lower-affine,convert-scf-to-cf,convert-arith-to-llvm),convert-vector-to-llvm,finalize-memref-to-llvm,convert-func-to-llvm,reconcile-unrealized-casts)" | "$daphne_dir/thirdparty/installed/bin/mlir-cpu-runner" -e main -entry-point-result=f32
