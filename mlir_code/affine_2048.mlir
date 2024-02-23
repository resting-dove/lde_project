func.func @main() -> f32 {
    %c0 = arith.constant 0 : index
    %c2048 = arith.constant 2048 : index
    %c2047 = arith.constant 2047 : index
    %c3 = arith.constant 3.0 : f32
    %c5 = arith.constant 5.0 : f32
    %alloc = memref.alloc() : memref<2048x2048xf32>
    %14 = memref.alloc() : memref<2048x2048xf32>
    %15 = memref.alloc() : memref<2048x2048xf32>
    %cst = arith.constant 0.000000e+00 : f32
    affine.for %arg0 = 0 to 2048 {
      affine.for %arg1 = 0 to 2048 {
        affine.store %cst, %alloc[%arg0, %arg1] : memref<2048x2048xf32>
      }
    }
    affine.for %arg0 = 0 to 2048 {
      affine.for %arg1 = 0 to 2048 {
        affine.store %c3, %14[%arg0, %arg1] : memref<2048x2048xf32>
      }
    }
    affine.for %arg0 = 0 to 2048 {
      affine.for %arg1 = 0 to 2048 {
        affine.store %c5, %15[%arg0, %arg1] : memref<2048x2048xf32>
      }
    }
    affine.for %arg0 = 0 to 2048 {
      affine.for %arg1 = 0 to 2048 {
        affine.for %arg2 = 0 to 2048 {
          %22 = affine.load %14[%arg0, %arg2] : memref<2048x2048xf32>
          %23 = affine.load %15[%arg2, %arg1] : memref<2048x2048xf32>
          %24 = affine.load %alloc[%arg0, %arg1] : memref<2048x2048xf32>
          %25 = llvm.intr.fma(%22, %23, %24)  : (f32, f32, f32) -> f32
          affine.store %25, %alloc[%arg0, %arg1] : memref<2048x2048xf32>
        }
      }
    }
    %117 = affine.load %alloc[%c2047, %c2047] : memref<2048x2048xf32>
    llvm.return %117 : f32
  }