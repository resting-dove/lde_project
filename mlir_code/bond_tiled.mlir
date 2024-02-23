#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> (d0 + 2048)>
#map2 = affine_map<(d0) -> (d0 + 64)>
#map3 = affine_map<(d0) -> (d0 + 256)>
#map4 = affine_map<(d0) -> (d0 + 32)>
#map5 = affine_map<(d0) -> (d0 + 4)>
#map6 = affine_map<(d0) -> (d0 + 1)>
#map7 = affine_map<(d0) -> (d0 + 2)>
#map8 = affine_map<(d0) -> (d0 + 3)>
#map9 = affine_map<(d0) -> (d0 + 8)>
#map10 = affine_map<(d0) -> (d0 + 12)>
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
        affine.for %arg2 = #map(%c0) to #map1(%c0) step 32 {
          affine.for %arg3 = #map(%arg1) to #map2(%arg1) step 4 {
            affine.for %arg4 = #map(%arg0) to #map3(%arg0) step 4 {
              affine.for %arg5 = #map(%arg2) to #map4(%arg2) step 16 {
                affine.for %arg6 = #map(%arg3) to #map5(%arg3) {
                  %22 = affine.load %14[%arg6, %arg4] : memref<2048x2048xf32>
                  %23 = vector.splat %22 : vector<4xf32>
                  %24 = affine.vector_load %15[%arg4, %arg5] : memref<2048x2048xf32>, vector<4xf32>
                  %25 = affine.vector_load %alloc[%arg6, %arg5] : memref<2048x2048xf32>, vector<4xf32>
                  %26 = vector.fma %23, %24, %25 : vector<4xf32>
                  affine.vector_store %26, %alloc[%arg6, %arg5] : memref<2048x2048xf32>, vector<4xf32>
                  %27 = affine.apply #map6(%arg4)
                  %28 = affine.load %14[%arg6, %27] : memref<2048x2048xf32>
                  %29 = vector.splat %28 : vector<4xf32>
                  %30 = affine.vector_load %15[%27, %arg5] : memref<2048x2048xf32>, vector<4xf32>
                  %31 = affine.vector_load %alloc[%arg6, %arg5] : memref<2048x2048xf32>, vector<4xf32>
                  %32 = vector.fma %29, %30, %31 : vector<4xf32>
                  affine.vector_store %32, %alloc[%arg6, %arg5] : memref<2048x2048xf32>, vector<4xf32>
                  %33 = affine.apply #map7(%arg4)
                  %34 = affine.load %14[%arg6, %33] : memref<2048x2048xf32>
                  %35 = vector.splat %34 : vector<4xf32>
                  %36 = affine.vector_load %15[%33, %arg5] : memref<2048x2048xf32>, vector<4xf32>
                  %37 = affine.vector_load %alloc[%arg6, %arg5] : memref<2048x2048xf32>, vector<4xf32>
                  %38 = vector.fma %35, %36, %37 : vector<4xf32>
                  affine.vector_store %38, %alloc[%arg6, %arg5] : memref<2048x2048xf32>, vector<4xf32>
                  %39 = affine.apply #map8(%arg4)
                  %40 = affine.load %14[%arg6, %39] : memref<2048x2048xf32>
                  %41 = vector.splat %40 : vector<4xf32>
                  %42 = affine.vector_load %15[%39, %arg5] : memref<2048x2048xf32>, vector<4xf32>
                  %43 = affine.vector_load %alloc[%arg6, %arg5] : memref<2048x2048xf32>, vector<4xf32>
                  %44 = vector.fma %41, %42, %43 : vector<4xf32>
                  affine.vector_store %44, %alloc[%arg6, %arg5] : memref<2048x2048xf32>, vector<4xf32>
                  %45 = affine.apply #map5(%arg5)
                  %46 = affine.load %14[%arg6, %arg4] : memref<2048x2048xf32>
                  %47 = vector.splat %46 : vector<4xf32>
                  %48 = affine.vector_load %15[%arg4, %45] : memref<2048x2048xf32>, vector<4xf32>
                  %49 = affine.vector_load %alloc[%arg6, %45] : memref<2048x2048xf32>, vector<4xf32>
                  %50 = vector.fma %47, %48, %49 : vector<4xf32>
                  affine.vector_store %50, %alloc[%arg6, %45] : memref<2048x2048xf32>, vector<4xf32>
                  %51 = affine.apply #map6(%arg4)
                  %52 = affine.load %14[%arg6, %51] : memref<2048x2048xf32>
                  %53 = vector.splat %52 : vector<4xf32>
                  %54 = affine.vector_load %15[%51, %45] : memref<2048x2048xf32>, vector<4xf32>
                  %55 = affine.vector_load %alloc[%arg6, %45] : memref<2048x2048xf32>, vector<4xf32>
                  %56 = vector.fma %53, %54, %55 : vector<4xf32>
                  affine.vector_store %56, %alloc[%arg6, %45] : memref<2048x2048xf32>, vector<4xf32>
                  %57 = affine.apply #map7(%arg4)
                  %58 = affine.load %14[%arg6, %57] : memref<2048x2048xf32>
                  %59 = vector.splat %58 : vector<4xf32>
                  %60 = affine.vector_load %15[%57, %45] : memref<2048x2048xf32>, vector<4xf32>
                  %61 = affine.vector_load %alloc[%arg6, %45] : memref<2048x2048xf32>, vector<4xf32>
                  %62 = vector.fma %59, %60, %61 : vector<4xf32>
                  affine.vector_store %62, %alloc[%arg6, %45] : memref<2048x2048xf32>, vector<4xf32>
                  %63 = affine.apply #map8(%arg4)
                  %64 = affine.load %14[%arg6, %63] : memref<2048x2048xf32>
                  %65 = vector.splat %64 : vector<4xf32>
                  %66 = affine.vector_load %15[%63, %45] : memref<2048x2048xf32>, vector<4xf32>
                  %67 = affine.vector_load %alloc[%arg6, %45] : memref<2048x2048xf32>, vector<4xf32>
                  %68 = vector.fma %65, %66, %67 : vector<4xf32>
                  affine.vector_store %68, %alloc[%arg6, %45] : memref<2048x2048xf32>, vector<4xf32>
                  %69 = affine.apply #map9(%arg5)
                  %70 = affine.load %14[%arg6, %arg4] : memref<2048x2048xf32>
                  %71 = vector.splat %70 : vector<4xf32>
                  %72 = affine.vector_load %15[%arg4, %69] : memref<2048x2048xf32>, vector<4xf32>
                  %73 = affine.vector_load %alloc[%arg6, %69] : memref<2048x2048xf32>, vector<4xf32>
                  %74 = vector.fma %71, %72, %73 : vector<4xf32>
                  affine.vector_store %74, %alloc[%arg6, %69] : memref<2048x2048xf32>, vector<4xf32>
                  %75 = affine.apply #map6(%arg4)
                  %76 = affine.load %14[%arg6, %75] : memref<2048x2048xf32>
                  %77 = vector.splat %76 : vector<4xf32>
                  %78 = affine.vector_load %15[%75, %69] : memref<2048x2048xf32>, vector<4xf32>
                  %79 = affine.vector_load %alloc[%arg6, %69] : memref<2048x2048xf32>, vector<4xf32>
                  %80 = vector.fma %77, %78, %79 : vector<4xf32>
                  affine.vector_store %80, %alloc[%arg6, %69] : memref<2048x2048xf32>, vector<4xf32>
                  %81 = affine.apply #map7(%arg4)
                  %82 = affine.load %14[%arg6, %81] : memref<2048x2048xf32>
                  %83 = vector.splat %82 : vector<4xf32>
                  %84 = affine.vector_load %15[%81, %69] : memref<2048x2048xf32>, vector<4xf32>
                  %85 = affine.vector_load %alloc[%arg6, %69] : memref<2048x2048xf32>, vector<4xf32>
                  %86 = vector.fma %83, %84, %85 : vector<4xf32>
                  affine.vector_store %86, %alloc[%arg6, %69] : memref<2048x2048xf32>, vector<4xf32>
                  %87 = affine.apply #map8(%arg4)
                  %88 = affine.load %14[%arg6, %87] : memref<2048x2048xf32>
                  %89 = vector.splat %88 : vector<4xf32>
                  %90 = affine.vector_load %15[%87, %69] : memref<2048x2048xf32>, vector<4xf32>
                  %91 = affine.vector_load %alloc[%arg6, %69] : memref<2048x2048xf32>, vector<4xf32>
                  %92 = vector.fma %89, %90, %91 : vector<4xf32>
                  affine.vector_store %92, %alloc[%arg6, %69] : memref<2048x2048xf32>, vector<4xf32>
                  %93 = affine.apply #map10(%arg5)
                  %94 = affine.load %14[%arg6, %arg4] : memref<2048x2048xf32>
                  %95 = vector.splat %94 : vector<4xf32>
                  %96 = affine.vector_load %15[%arg4, %93] : memref<2048x2048xf32>, vector<4xf32>
                  %97 = affine.vector_load %alloc[%arg6, %93] : memref<2048x2048xf32>, vector<4xf32>
                  %98 = vector.fma %95, %96, %97 : vector<4xf32>
                  affine.vector_store %98, %alloc[%arg6, %93] : memref<2048x2048xf32>, vector<4xf32>
                  %99 = affine.apply #map6(%arg4)
                  %100 = affine.load %14[%arg6, %99] : memref<2048x2048xf32>
                  %101 = vector.splat %100 : vector<4xf32>
                  %102 = affine.vector_load %15[%99, %93] : memref<2048x2048xf32>, vector<4xf32>
                  %103 = affine.vector_load %alloc[%arg6, %93] : memref<2048x2048xf32>, vector<4xf32>
                  %104 = vector.fma %101, %102, %103 : vector<4xf32>
                  affine.vector_store %104, %alloc[%arg6, %93] : memref<2048x2048xf32>, vector<4xf32>
                  %105 = affine.apply #map7(%arg4)
                  %106 = affine.load %14[%arg6, %105] : memref<2048x2048xf32>
                  %107 = vector.splat %106 : vector<4xf32>
                  %108 = affine.vector_load %15[%105, %93] : memref<2048x2048xf32>, vector<4xf32>
                  %109 = affine.vector_load %alloc[%arg6, %93] : memref<2048x2048xf32>, vector<4xf32>
                  %110 = vector.fma %107, %108, %109 : vector<4xf32>
                  affine.vector_store %110, %alloc[%arg6, %93] : memref<2048x2048xf32>, vector<4xf32>
                  %111 = affine.apply #map8(%arg4)
                  %112 = affine.load %14[%arg6, %111] : memref<2048x2048xf32>
                  %113 = vector.splat %112 : vector<4xf32>
                  %114 = affine.vector_load %15[%111, %93] : memref<2048x2048xf32>, vector<4xf32>
                  %115 = affine.vector_load %alloc[%arg6, %93] : memref<2048x2048xf32>, vector<4xf32>
                  %116 = vector.fma %113, %114, %115 : vector<4xf32>
                  affine.vector_store %116, %alloc[%arg6, %93] : memref<2048x2048xf32>, vector<4xf32>
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
