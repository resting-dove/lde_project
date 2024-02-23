#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> (d0 + 2048)>
#map2 = affine_map<(d0) -> (d0 + 64)>
#map3 = affine_map<(d0) -> (d0 + 256)>
#map4 = affine_map<(d0) -> (d0 + 8)>
#map5 = affine_map<(d0) -> (d0 + 4)>
#map6 = affine_map<(d0) -> (d0 + 1)>
#map7 = affine_map<(d0) -> (d0 + 2)>
#map8 = affine_map<(d0) -> (d0 + 3)>
module {
  func.func @main() -> f32 {
    %c0 = arith.constant 0 : index
    %c2047 = arith.constant 2047 : index
    %alloc = memref.alloc() : memref<2048x2048xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %14 = memref.alloc() : memref<2048x2048xf32>
    %15 = memref.alloc() : memref<2048x2048xf32>
    affine.for %arg0 = 0 to 2048 {
      affine.for %arg1 = 0 to 2048 {
        affine.store %cst, %alloc[%arg0, %arg1] : memref<2048x2048xf32>
      }
    }
    %c3 = arith.constant 3.0 : f32
    %c5 = arith.constant 5.0 : f32
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
    affine.for %arg0 = 0 to 2048 step 256 {
      affine.for %arg1 = 0 to 2048 step 64 {
        affine.for %arg2 = #map(%c0) to #map1(%c0) step 8 {
          affine.for %arg3 = #map(%arg1) to #map2(%arg1) step 4 {
            affine.for %arg4 = #map(%arg0) to #map3(%arg0) step 4 {
              affine.for %arg5 = #map(%arg2) to #map4(%arg2) step 4 {
                affine.for %arg6 = #map(%arg3) to #map5(%arg3) {
                  %22 = affine.load %14[%arg6, %arg4] : memref<2048x2048xf32>
                  %23 = affine.load %15[%arg4, %arg5] : memref<2048x2048xf32>
                  %24 = affine.load %alloc[%arg6, %arg5] : memref<2048x2048xf32>
                  %25 = llvm.intr.fma(%22, %23, %24)  : (f32, f32, f32) -> f32
                  affine.store %25, %alloc[%arg6, %arg5] : memref<2048x2048xf32>
                  %26 = affine.apply #map6(%arg4)
                  %27 = affine.load %14[%arg6, %26] : memref<2048x2048xf32>
                  %28 = affine.load %15[%26, %arg5] : memref<2048x2048xf32>
                  %29 = affine.load %alloc[%arg6, %arg5] : memref<2048x2048xf32>
                  %30 = llvm.intr.fma(%27, %28, %29)  : (f32, f32, f32) -> f32
                  affine.store %30, %alloc[%arg6, %arg5] : memref<2048x2048xf32>
                  %31 = affine.apply #map7(%arg4)
                  %32 = affine.load %14[%arg6, %31] : memref<2048x2048xf32>
                  %33 = affine.load %15[%31, %arg5] : memref<2048x2048xf32>
                  %34 = affine.load %alloc[%arg6, %arg5] : memref<2048x2048xf32>
                  %35 = llvm.intr.fma(%32, %33, %34)  : (f32, f32, f32) -> f32
                  affine.store %35, %alloc[%arg6, %arg5] : memref<2048x2048xf32>
                  %36 = affine.apply #map8(%arg4)
                  %37 = affine.load %14[%arg6, %36] : memref<2048x2048xf32>
                  %38 = affine.load %15[%36, %arg5] : memref<2048x2048xf32>
                  %39 = affine.load %alloc[%arg6, %arg5] : memref<2048x2048xf32>
                  %40 = llvm.intr.fma(%37, %38, %39)  : (f32, f32, f32) -> f32
                  affine.store %40, %alloc[%arg6, %arg5] : memref<2048x2048xf32>
                  %41 = affine.apply #map6(%arg5)
                  %42 = affine.load %14[%arg6, %arg4] : memref<2048x2048xf32>
                  %43 = affine.load %15[%arg4, %41] : memref<2048x2048xf32>
                  %44 = affine.load %alloc[%arg6, %41] : memref<2048x2048xf32>
                  %45 = llvm.intr.fma(%42, %43, %44)  : (f32, f32, f32) -> f32
                  affine.store %45, %alloc[%arg6, %41] : memref<2048x2048xf32>
                  %46 = affine.apply #map6(%arg4)
                  %47 = affine.load %14[%arg6, %46] : memref<2048x2048xf32>
                  %48 = affine.load %15[%46, %41] : memref<2048x2048xf32>
                  %49 = affine.load %alloc[%arg6, %41] : memref<2048x2048xf32>
                  %50 = llvm.intr.fma(%47, %48, %49)  : (f32, f32, f32) -> f32
                  affine.store %50, %alloc[%arg6, %41] : memref<2048x2048xf32>
                  %51 = affine.apply #map7(%arg4)
                  %52 = affine.load %14[%arg6, %51] : memref<2048x2048xf32>
                  %53 = affine.load %15[%51, %41] : memref<2048x2048xf32>
                  %54 = affine.load %alloc[%arg6, %41] : memref<2048x2048xf32>
                  %55 = llvm.intr.fma(%52, %53, %54)  : (f32, f32, f32) -> f32
                  affine.store %55, %alloc[%arg6, %41] : memref<2048x2048xf32>
                  %56 = affine.apply #map8(%arg4)
                  %57 = affine.load %14[%arg6, %56] : memref<2048x2048xf32>
                  %58 = affine.load %15[%56, %41] : memref<2048x2048xf32>
                  %59 = affine.load %alloc[%arg6, %41] : memref<2048x2048xf32>
                  %60 = llvm.intr.fma(%57, %58, %59)  : (f32, f32, f32) -> f32
                  affine.store %60, %alloc[%arg6, %41] : memref<2048x2048xf32>
                  %61 = affine.apply #map7(%arg5)
                  %62 = affine.load %14[%arg6, %arg4] : memref<2048x2048xf32>
                  %63 = affine.load %15[%arg4, %61] : memref<2048x2048xf32>
                  %64 = affine.load %alloc[%arg6, %61] : memref<2048x2048xf32>
                  %65 = llvm.intr.fma(%62, %63, %64)  : (f32, f32, f32) -> f32
                  affine.store %65, %alloc[%arg6, %61] : memref<2048x2048xf32>
                  %66 = affine.apply #map6(%arg4)
                  %67 = affine.load %14[%arg6, %66] : memref<2048x2048xf32>
                  %68 = affine.load %15[%66, %61] : memref<2048x2048xf32>
                  %69 = affine.load %alloc[%arg6, %61] : memref<2048x2048xf32>
                  %70 = llvm.intr.fma(%67, %68, %69)  : (f32, f32, f32) -> f32
                  affine.store %70, %alloc[%arg6, %61] : memref<2048x2048xf32>
                  %71 = affine.apply #map7(%arg4)
                  %72 = affine.load %14[%arg6, %71] : memref<2048x2048xf32>
                  %73 = affine.load %15[%71, %61] : memref<2048x2048xf32>
                  %74 = affine.load %alloc[%arg6, %61] : memref<2048x2048xf32>
                  %75 = llvm.intr.fma(%72, %73, %74)  : (f32, f32, f32) -> f32
                  affine.store %75, %alloc[%arg6, %61] : memref<2048x2048xf32>
                  %76 = affine.apply #map8(%arg4)
                  %77 = affine.load %14[%arg6, %76] : memref<2048x2048xf32>
                  %78 = affine.load %15[%76, %61] : memref<2048x2048xf32>
                  %79 = affine.load %alloc[%arg6, %61] : memref<2048x2048xf32>
                  %80 = llvm.intr.fma(%77, %78, %79)  : (f32, f32, f32) -> f32
                  affine.store %80, %alloc[%arg6, %61] : memref<2048x2048xf32>
                  %81 = affine.apply #map8(%arg5)
                  %82 = affine.load %14[%arg6, %arg4] : memref<2048x2048xf32>
                  %83 = affine.load %15[%arg4, %81] : memref<2048x2048xf32>
                  %84 = affine.load %alloc[%arg6, %81] : memref<2048x2048xf32>
                  %85 = llvm.intr.fma(%82, %83, %84)  : (f32, f32, f32) -> f32
                  affine.store %85, %alloc[%arg6, %81] : memref<2048x2048xf32>
                  %86 = affine.apply #map6(%arg4)
                  %87 = affine.load %14[%arg6, %86] : memref<2048x2048xf32>
                  %88 = affine.load %15[%86, %81] : memref<2048x2048xf32>
                  %89 = affine.load %alloc[%arg6, %81] : memref<2048x2048xf32>
                  %90 = llvm.intr.fma(%87, %88, %89)  : (f32, f32, f32) -> f32
                  affine.store %90, %alloc[%arg6, %81] : memref<2048x2048xf32>
                  %91 = affine.apply #map7(%arg4)
                  %92 = affine.load %14[%arg6, %91] : memref<2048x2048xf32>
                  %93 = affine.load %15[%91, %81] : memref<2048x2048xf32>
                  %94 = affine.load %alloc[%arg6, %81] : memref<2048x2048xf32>
                  %95 = llvm.intr.fma(%92, %93, %94)  : (f32, f32, f32) -> f32
                  affine.store %95, %alloc[%arg6, %81] : memref<2048x2048xf32>
                  %96 = affine.apply #map8(%arg4)
                  %97 = affine.load %14[%arg6, %96] : memref<2048x2048xf32>
                  %98 = affine.load %15[%96, %81] : memref<2048x2048xf32>
                  %99 = affine.load %alloc[%arg6, %81] : memref<2048x2048xf32>
                  %100 = llvm.intr.fma(%97, %98, %99)  : (f32, f32, f32) -> f32
                  affine.store %100, %alloc[%arg6, %81] : memref<2048x2048xf32>
                }
              }
            }
          }
        }
      }
    }
    %117 = affine.load %alloc[%c2047, %c2047] : memref<2048x2048xf32>
    llvm.return %117 : f32
  }
}