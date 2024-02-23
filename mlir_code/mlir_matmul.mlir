module {
  func.func @main() {
    %c1 = arith.constant 1 : index
    %c2048 = arith.constant 2048 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f64
    %0 = "daphne.constant"() {value = 42 : si64} : () -> si64
    %1 = "daphne.constant"() {value = 1.000000e+00 : f64} : () -> f64
    %2 = "daphne.constant"() {value = 1.000000e+01 : f64} : () -> f64
    %3 = "daphne.constant"() {value = -1.000000e+01 : f64} : () -> f64
    %4 = "daphne.constant"() {value = 44 : si64} : () -> si64
    %5 = "daphne.constant"() {value = "GEMM took "} : () -> !daphne.String
    %6 = "daphne.constant"() {value = 1.000000e+06 : f64} : () -> f64
    %7 = "daphne.constant"() {value = "ms"} : () -> !daphne.String
    %8 = "daphne.constant"() {value = 2048 : index} : () -> index
    %9 = "daphne.constant"() {value = false} : () -> i1
    %10 = "daphne.constant"() {value = true} : () -> i1
    %alloc = memref.alloc() : memref<2048x2048xf64>
    %11 = "daphne.randMatrix"(%8, %8, %3, %2, %1, %0) : (index, index, f64, f64, f64, si64) -> !daphne.Matrix<2048x2048xf64:sp[1.000000e+00]>
    %12 = "daphne.randMatrix"(%8, %8, %3, %2, %1, %4) : (index, index, f64, f64, f64, si64) -> !daphne.Matrix<2048x2048xf64:sp[1.000000e+00]>
    %13 = "daphne.now"() : () -> si64
    %14 = "daphne.convertDenseMatrixToMemRef"(%11) : (!daphne.Matrix<2048x2048xf64:sp[1.000000e+00]>) -> memref<2048x2048xf64>
    %15 = "daphne.convertDenseMatrixToMemRef"(%12) : (!daphne.Matrix<2048x2048xf64:sp[1.000000e+00]>) -> memref<2048x2048xf64>
    affine.for %arg0 = 0 to 2048 {
      affine.for %arg1 = 0 to 2048 {
        affine.store %cst, %alloc[%arg0, %arg1] : memref<2048x2048xf64>
      }
    }
    affine.for %arg0 = 0 to 2048 {
      affine.for %arg1 = 0 to 2048 {
        affine.for %arg2 = 0 to 2048 {
          %22 = affine.load %14[%arg0, %arg2] : memref<2048x2048xf64>
          %23 = affine.load %15[%arg2, %arg1] : memref<2048x2048xf64>
          %24 = affine.load %alloc[%arg0, %arg1] : memref<2048x2048xf64>
          %25 = math.fma %22, %23, %24 : f64
          affine.store %25, %alloc[%arg0, %arg1] : memref<2048x2048xf64>
        }
      }
    }
    %intptr = memref.extract_aligned_pointer_as_index %alloc : memref<2048x2048xf64> -> index
    %16 = "daphne.convertMemRefToDenseMatrix"(%intptr, %c0, %c2048, %c2048, %c2048, %c1) : (index, index, index, index, index, index) -> !daphne.Matrix<2048x2048xf64:sp[1.000000e+00]>
    %17 = "daphne.now"() : () -> si64
    "daphne.print"(%5, %9, %9) : (!daphne.String, i1, i1) -> ()
    %18 = "daphne.ewSub"(%17, %13) : (si64, si64) -> si64
    %19 = "daphne.cast"(%18) : (si64) -> f64
    %20 = "daphne.ewDiv"(%19, %6) : (f64, f64) -> f64
    "daphne.print"(%20, %9, %9) : (f64, i1, i1) -> ()
    "daphne.print"(%7, %10, %9) : (!daphne.String, i1, i1) -> ()
    %21 = "daphne.sumAll"(%16) : (!daphne.Matrix<2048x2048xf64:sp[1.000000e+00]>) -> f64
    "daphne.print"(%21, %10, %9) : (f64, i1, i1) -> ()
    "daphne.return"() : () -> ()
  }
}
