func.func @main() -> f32 {
    %c0 = arith.constant 0 : index
    %c20 = arith.constant 20 : index
    %c19 = arith.constant 19 : index
    %c3 = arith.constant 3.0 : f32
    %c5 = arith.constant 5.0 : f32
    %alloc = memref.alloc() : memref<20x20xf32>
    %14 = memref.alloc() : memref<20x20xf32>
    %15 = memref.alloc() : memref<20x20xf32>
    %cst = arith.constant 0.000000e+00 : f32
    affine.for %arg0 = 0 to 20 {
      affine.for %arg1 = 0 to 20 {
        affine.store %cst, %alloc[%arg0, %arg1] : memref<20x20xf32>
      }
    }
    affine.for %arg0 = 0 to 20 {
      affine.for %arg1 = 0 to 20 {
        affine.store %c3, %14[%arg0, %arg1] : memref<20x20xf32>
      }
    }
    affine.for %arg0 = 0 to 20 {
      affine.for %arg1 = 0 to 20 {
        affine.store %c5, %15[%arg0, %arg1] : memref<20x20xf32>
      }
    }
    affine.for %arg0 = 0 to 20 {
      affine.for %arg1 = 0 to 20 {
        affine.for %arg2 = 0 to 20 {
          %22 = affine.load %14[%arg0, %arg2] : memref<20x20xf32>
          %23 = affine.load %15[%arg2, %arg1] : memref<20x20xf32>
          %24 = affine.load %alloc[%arg0, %arg1] : memref<20x20xf32>
          %25 = llvm.intr.fma(%22, %23, %24)  : (f32, f32, f32) -> f32
          affine.store %25, %alloc[%arg0, %arg1] : memref<20x20xf32>
        }
      }
    }
    %117 = affine.load %alloc[0, 0] : memref<20x20xf32>
    llvm.return %117 : f32
  }