module {
  func.func @main() {
    %alloc = memref.alloc() : memref<512x512xf64>
    %cst = arith.constant 0.000000e+00 : f64
    affine.for %arg3 = 0 to 512 {
    affine.for %arg0 = 0 to 512 {
      affine.for %arg1 = 0 to 512 {
        affine.store %cst, %alloc[%arg0, %arg1] : memref<512x512xf64>
      }
    }
  }
    "daphne.return"() : () -> ()
  }
}