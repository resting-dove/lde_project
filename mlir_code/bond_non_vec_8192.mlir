#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> (d0 + 8192)>
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
    %c8191 = arith.constant 8191 : index
    %alloc = memref.alloc() : memref<8192x8192xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %16 = memref.alloc() : memref<8192x8192xf32>
    %17 = memref.alloc() : memref<8192x8192xf32>
    affine.for %arg0 = 0 to 8192 {
      affine.for %arg1 = 0 to 8192 {
        affine.store %cst, %alloc[%arg0, %arg1] : memref<8192x8192xf32>
      }
    }
    %c3 = arith.constant 3.0 : f32
    %c5 = arith.constant 5.0 : f32
    affine.for %arg0 = 0 to 8192 {
      affine.for %arg1 = 0 to 8192 {
        affine.store %c3, %16[%arg0, %arg1] : memref<8192x8192xf32>
      }
    }
    affine.for %arg0 = 0 to 8192 {
      affine.for %arg1 = 0 to 8192 {
        affine.store %c5, %17[%arg0, %arg1] : memref<8192x8192xf32>
      }
    }  
    affine.for %arg0 = 0 to 8192 step 256 {
      affine.for %arg1 = 0 to 8192 step 64 {
        affine.for %arg2 = #map(%c0) to #map1(%c0) step 8 {
          affine.for %arg3 = #map(%arg1) to #map2(%arg1) step 4 {
            affine.for %arg4 = #map(%arg0) to #map3(%arg0) step 4 {
              affine.for %arg5 = #map(%arg2) to #map4(%arg2) step 4 {
                affine.for %arg6 = #map(%arg3) to #map5(%arg3) {
                  %28 = affine.load %16[%arg6, %arg4] : memref<8192x8192xf32>
                  %29 = affine.load %17[%arg4, %arg5] : memref<8192x8192xf32>
                  %30 = affine.load %alloc[%arg6, %arg5] : memref<8192x8192xf32>
                  %31 = llvm.intr.fma(%28, %29, %30)  : (f32, f32, f32) -> f32
                  affine.store %31, %alloc[%arg6, %arg5] : memref<8192x8192xf32>
                  %32 = affine.apply #map6(%arg4)
                  %33 = affine.load %16[%arg6, %32] : memref<8192x8192xf32>
                  %34 = affine.load %17[%32, %arg5] : memref<8192x8192xf32>
                  %35 = affine.load %alloc[%arg6, %arg5] : memref<8192x8192xf32>
                  %36 = llvm.intr.fma(%33, %34, %35)  : (f32, f32, f32) -> f32
                  affine.store %36, %alloc[%arg6, %arg5] : memref<8192x8192xf32>
                  %37 = affine.apply #map7(%arg4)
                  %38 = affine.load %16[%arg6, %37] : memref<8192x8192xf32>
                  %39 = affine.load %17[%37, %arg5] : memref<8192x8192xf32>
                  %40 = affine.load %alloc[%arg6, %arg5] : memref<8192x8192xf32>
                  %41 = llvm.intr.fma(%38, %39, %40)  : (f32, f32, f32) -> f32
                  affine.store %41, %alloc[%arg6, %arg5] : memref<8192x8192xf32>
                  %42 = affine.apply #map8(%arg4)
                  %43 = affine.load %16[%arg6, %42] : memref<8192x8192xf32>
                  %44 = affine.load %17[%42, %arg5] : memref<8192x8192xf32>
                  %45 = affine.load %alloc[%arg6, %arg5] : memref<8192x8192xf32>
                  %46 = llvm.intr.fma(%43, %44, %45)  : (f32, f32, f32) -> f32
                  affine.store %46, %alloc[%arg6, %arg5] : memref<8192x8192xf32>
                  %47 = affine.apply #map6(%arg5)
                  %48 = affine.load %16[%arg6, %arg4] : memref<8192x8192xf32>
                  %49 = affine.load %17[%arg4, %47] : memref<8192x8192xf32>
                  %50 = affine.load %alloc[%arg6, %47] : memref<8192x8192xf32>
                  %51 = llvm.intr.fma(%48, %49, %50)  : (f32, f32, f32) -> f32
                  affine.store %51, %alloc[%arg6, %47] : memref<8192x8192xf32>
                  %52 = affine.apply #map6(%arg4)
                  %53 = affine.load %16[%arg6, %52] : memref<8192x8192xf32>
                  %54 = affine.load %17[%52, %47] : memref<8192x8192xf32>
                  %55 = affine.load %alloc[%arg6, %47] : memref<8192x8192xf32>
                  %56 = llvm.intr.fma(%53, %54, %55)  : (f32, f32, f32) -> f32
                  affine.store %56, %alloc[%arg6, %47] : memref<8192x8192xf32>
                  %57 = affine.apply #map7(%arg4)
                  %58 = affine.load %16[%arg6, %57] : memref<8192x8192xf32>
                  %59 = affine.load %17[%57, %47] : memref<8192x8192xf32>
                  %60 = affine.load %alloc[%arg6, %47] : memref<8192x8192xf32>
                  %61 = llvm.intr.fma(%58, %59, %60)  : (f32, f32, f32) -> f32
                  affine.store %61, %alloc[%arg6, %47] : memref<8192x8192xf32>
                  %62 = affine.apply #map8(%arg4)
                  %63 = affine.load %16[%arg6, %62] : memref<8192x8192xf32>
                  %64 = affine.load %17[%62, %47] : memref<8192x8192xf32>
                  %65 = affine.load %alloc[%arg6, %47] : memref<8192x8192xf32>
                  %66 = llvm.intr.fma(%63, %64, %65)  : (f32, f32, f32) -> f32
                  affine.store %66, %alloc[%arg6, %47] : memref<8192x8192xf32>
                  %67 = affine.apply #map7(%arg5)
                  %68 = affine.load %16[%arg6, %arg4] : memref<8192x8192xf32>
                  %69 = affine.load %17[%arg4, %67] : memref<8192x8192xf32>
                  %70 = affine.load %alloc[%arg6, %67] : memref<8192x8192xf32>
                  %71 = llvm.intr.fma(%68, %69, %70)  : (f32, f32, f32) -> f32
                  affine.store %71, %alloc[%arg6, %67] : memref<8192x8192xf32>
                  %72 = affine.apply #map6(%arg4)
                  %73 = affine.load %16[%arg6, %72] : memref<8192x8192xf32>
                  %74 = affine.load %17[%72, %67] : memref<8192x8192xf32>
                  %75 = affine.load %alloc[%arg6, %67] : memref<8192x8192xf32>
                  %76 = llvm.intr.fma(%73, %74, %75)  : (f32, f32, f32) -> f32
                  affine.store %76, %alloc[%arg6, %67] : memref<8192x8192xf32>
                  %77 = affine.apply #map7(%arg4)
                  %78 = affine.load %16[%arg6, %77] : memref<8192x8192xf32>
                  %79 = affine.load %17[%77, %67] : memref<8192x8192xf32>
                  %80 = affine.load %alloc[%arg6, %67] : memref<8192x8192xf32>
                  %81 = llvm.intr.fma(%78, %79, %80)  : (f32, f32, f32) -> f32
                  affine.store %81, %alloc[%arg6, %67] : memref<8192x8192xf32>
                  %82 = affine.apply #map8(%arg4)
                  %83 = affine.load %16[%arg6, %82] : memref<8192x8192xf32>
                  %84 = affine.load %17[%82, %67] : memref<8192x8192xf32>
                  %85 = affine.load %alloc[%arg6, %67] : memref<8192x8192xf32>
                  %86 = llvm.intr.fma(%83, %84, %85)  : (f32, f32, f32) -> f32
                  affine.store %86, %alloc[%arg6, %67] : memref<8192x8192xf32>
                  %87 = affine.apply #map8(%arg5)
                  %88 = affine.load %16[%arg6, %arg4] : memref<8192x8192xf32>
                  %89 = affine.load %17[%arg4, %87] : memref<8192x8192xf32>
                  %90 = affine.load %alloc[%arg6, %87] : memref<8192x8192xf32>
                  %91 = llvm.intr.fma(%88, %89, %90)  : (f32, f32, f32) -> f32
                  affine.store %91, %alloc[%arg6, %87] : memref<8192x8192xf32>
                  %92 = affine.apply #map6(%arg4)
                  %93 = affine.load %16[%arg6, %92] : memref<8192x8192xf32>
                  %94 = affine.load %17[%92, %87] : memref<8192x8192xf32>
                  %95 = affine.load %alloc[%arg6, %87] : memref<8192x8192xf32>
                  %96 = llvm.intr.fma(%93, %94, %95)  : (f32, f32, f32) -> f32
                  affine.store %96, %alloc[%arg6, %87] : memref<8192x8192xf32>
                  %97 = affine.apply #map7(%arg4)
                  %98 = affine.load %16[%arg6, %97] : memref<8192x8192xf32>
                  %99 = affine.load %17[%97, %87] : memref<8192x8192xf32>
                  %100 = affine.load %alloc[%arg6, %87] : memref<8192x8192xf32>
                  %101 = llvm.intr.fma(%98, %99, %100)  : (f32, f32, f32) -> f32
                  affine.store %101, %alloc[%arg6, %87] : memref<8192x8192xf32>
                  %102 = affine.apply #map8(%arg4)
                  %103 = affine.load %16[%arg6, %102] : memref<8192x8192xf32>
                  %104 = affine.load %17[%102, %87] : memref<8192x8192xf32>
                  %105 = affine.load %alloc[%arg6, %87] : memref<8192x8192xf32>
                  %106 = llvm.intr.fma(%103, %104, %105)  : (f32, f32, f32) -> f32
                  affine.store %106, %alloc[%arg6, %87] : memref<8192x8192xf32>
                }
              }
            }
          }
        }
      }
    }
    %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %alloc : memref<8192x8192xf32> -> memref<f32>, index, index, index, index, index
    %intptr = memref.extract_aligned_pointer_as_index %alloc : memref<8192x8192xf32> -> index
    %27 = affine.for %arg0 = 0 to 8192 iter_args(%arg1 = %cst) -> (f32) {
      %28 = affine.for %arg2 = 0 to 8192 iter_args(%arg3 = %cst) -> (f32) {
        %30 = memref.load %alloc[%arg0, %arg2] : memref<8192x8192xf32>
        %31 = arith.addf %arg3, %30 : f32
        affine.yield %31 : f32
      }
      %29 = arith.addf %arg1, %28 : f32
      affine.yield %29 : f32
    }
    %117 = affine.load %alloc[%c8191, %c8191] : memref<8192x8192xf32>
    llvm.return %117 : f32
  }
}
