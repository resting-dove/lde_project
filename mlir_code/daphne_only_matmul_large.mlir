module {
  func.func @main() {
   %0 = "daphne.constant"() {value = 10 : index} : () -> index
    %1 = "daphne.constant"() {value = false} : () -> i1
    %2 = "daphne.constant"() {value = 3.000000e+00 : f64} : () -> f64
    %3 = "daphne.constant"() {value = 5.000000e+00 : f64} : () -> f64
    %4 = "daphne.fill"(%3, %0, %0) : (f64, index, index) -> !daphne.Matrix<200x200xf64>
    %5 = "daphne.fill"(%2, %0, %0) : (f64, index, index) -> !daphne.Matrix<200x200xf64>
    %6 = "daphne.matMul"(%4, %5, %1, %1) : (!daphne.Matrix<200x200xf64>, !daphne.Matrix<200x200xf64>, i1, i1) -> !daphne.Matrix<200x200xf64>
    "daphne.return"() : () -> ()
  }
}
