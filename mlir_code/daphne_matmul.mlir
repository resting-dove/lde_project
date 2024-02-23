module {
  func.func @main() {
    %0 = "daphne.constant"() {value = true} : () -> i1
    %1 = "daphne.constant"() {value = false} : () -> i1
    %2 = "daphne.constant"() {value = 512 : index} : () -> index
    %3 = "daphne.constant"() {value = "ms"} : () -> !daphne.String
    %4 = "daphne.constant"() {value = 1.000000e+06 : f64} : () -> f64
    %5 = "daphne.constant"() {value = "GEMM took "} : () -> !daphne.String
    %6 = "daphne.constant"() {value = 44 : si64} : () -> si64
    %7 = "daphne.constant"() {value = -1.000000e+01 : f64} : () -> f64
    %8 = "daphne.constant"() {value = 1.000000e+01 : f64} : () -> f64
    %9 = "daphne.constant"() {value = 1.000000e+00 : f64} : () -> f64
    %10 = "daphne.constant"() {value = 42 : si64} : () -> si64
    %11 = "daphne.randMatrix"(%2, %2, %7, %8, %9, %10) : (index, index, f64, f64, f64, si64) -> !daphne.Matrix<512x512xf64:sp[1.000000e+00]>
    %12 = "daphne.randMatrix"(%2, %2, %7, %8, %9, %6) : (index, index, f64, f64, f64, si64) -> !daphne.Matrix<512x512xf64:sp[1.000000e+00]>
    %13 = "daphne.now"() : () -> si64
    %14 = "daphne.matMul"(%11, %12, %1, %1) : (!daphne.Matrix<512x512xf64:sp[1.000000e+00]>, !daphne.Matrix<512x512xf64:sp[1.000000e+00]>, i1, i1) -> !daphne.Matrix<512x512xf64:sp[1.000000e+00]>
    %15 = "daphne.now"() : () -> si64
    "daphne.print"(%5, %1, %1) : (!daphne.String, i1, i1) -> ()
    %16 = "daphne.ewSub"(%15, %13) : (si64, si64) -> si64
    %17 = "daphne.cast"(%16) : (si64) -> f64
    %18 = "daphne.ewDiv"(%17, %4) : (f64, f64) -> f64
    "daphne.print"(%18, %1, %1) : (f64, i1, i1) -> ()
    "daphne.print"(%3, %0, %1) : (!daphne.String, i1, i1) -> ()
    %19 = "daphne.sumAll"(%14) : (!daphne.Matrix<512x512xf64:sp[1.000000e+00]>) -> f64
    "daphne.print"(%19, %0, %1) : (f64, i1, i1) -> ()
    "daphne.return"() : () -> ()
  }
}
