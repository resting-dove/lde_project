#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> (d0 + 2048)>
#map2 = affine_map<(d0) -> (d0 + 32, 2048)>
#map3 = affine_map<(d0) -> (d0 + 128, 2048)>
#map4 = affine_map<(d0, d1) -> (d1 + 4, d0 + 2048)>
#map5 = affine_map<(d0, d1) -> (d1 + 4, d0 + 32, 2048)>
  func.func @main() -> f32 {
    %c0 = arith.constant 0 : index
    %c2047 = arith.constant 2047 : index
    %alloc = memref.alloc() : memref<2048x2048xf64>
    %14 = memref.alloc() : memref<2048x2048xf64>
    %15 = memref.alloc() : memref<2048x2048xf64>
    %cst = arith.constant 0.000000e+00 : f64
    affine.for %arg0 = 0 to 2048 {
      affine.for %arg1 = 0 to 2048 {
        affine.store %cst, %alloc[%arg0, %arg1] : memref<2048x2048xf64>
      }
    }
    affine.for %arg0 = 0 to 2048 step 128 {
      affine.for %arg1 = 0 to 2048 step 32 {
        affine.for %arg2 = #map(%c0) to #map1(%c0) step 4 {
          affine.for %arg3 = #map(%arg1) to min #map2(%arg1) step 4 {
            affine.for %arg4 = #map(%arg0) to min #map3(%arg0) {
              affine.for %arg5 = #map(%arg2) to min #map4(%c0, %arg2) {
                affine.for %arg6 = #map(%arg3) to min #map5(%arg1, %arg3) {
                  %22 = affine.load %14[%arg6, %arg4] : memref<2048x2048xf64>
                  %23 = affine.load %15[%arg4, %arg5] : memref<2048x2048xf64>
                  %24 = affine.load %alloc[%arg6, %arg5] : memref<2048x2048xf64>
                  %25 = llvm.intr.fma(%22, %23, %24)  : (f64, f64, f64) -> f64
                  affine.store %25, %alloc[%arg6, %arg5] : memref<2048x2048xf64>
                }
              }
            }
          }
        }
      }
    }
    %26 = affine.load %alloc[%c2047, %c2047] : memref<2048x2048xf64>
    %27 =  llvm.fptrunc %26 : f64 to f32
    llvm.return %27 : f32
  }