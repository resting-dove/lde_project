module {
  func.func @main() {
  %0 = "daphne.constant"() {value = 10 : index} : () -> index
    %1 = "daphne.constant"() {value = false} : () -> i1
    %2 = "daphne.constant"() {value = 3.000000e+00 : f32} : () -> f32
    %3 = "daphne.constant"() {value = 5.000000e+00 : f32} : () -> f32
    %4 = "daphne.fill"(%3, %0, %0) : (f32, index, index) -> !daphne.Matrix<10x10xf32>
    %5 = "daphne.fill"(%2, %0, %0) : (f32, index, index) -> !daphne.Matrix<10x10xf32> 
    %6 = "daphne.matMul"(%4, %5, %1, %1) : (!daphne.Matrix<10x10xf32>, !daphne.Matrix<10x10xf32>, i1, i1) -> !daphne.Matrix<10x10xf32>
    "daphne.return"() : () -> ()
  }
}
