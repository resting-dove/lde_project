#!/bin/bash

daphne_dir=$1
"$daphne_dir"/bin/daphne --mlir-codegen ./scripts/matmul/matmul2048.daph