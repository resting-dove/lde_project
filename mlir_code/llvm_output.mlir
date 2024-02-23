module {
  llvm.func @_destroyDaphneContext(!llvm.ptr<i1>)
  llvm.func @_convertDenseMatrixToMemRef__StridedMemRefType_double_2__DenseMatrix_double(!llvm.ptr<struct<(ptr<f64>, ptr<f64>, i64, array<2 x i64>, array<2 x i64>)>>, !llvm.ptr<i1>, !llvm.ptr<i1>)
  llvm.func @_randMatrix__DenseMatrix_double__size_t__size_t__double__double__double__int64_t(!llvm.ptr<ptr<i1>>, i64, i64, f64, f64, f64, i64, !llvm.ptr<i1>)
  llvm.func @_decRef__Structure(!llvm.ptr<i1>, !llvm.ptr<i1>)
  llvm.func @_convertMemRefToDenseMatrix__DenseMatrix_double__size_t__size_t__size_t__size_t__size_t__size_t(!llvm.ptr<ptr<i1>>, i64, i64, i64, i64, i64, i64, !llvm.ptr<i1>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @_createDaphneContext__DaphneContext__uint64_t(!llvm.ptr<ptr<i1>>, i64)
  llvm.func @main() {
    %0 = llvm.mlir.constant(512 : index) : i64
    %1 = llvm.mlir.constant(44 : si64) : i64
    %2 = llvm.mlir.constant(-1.000000e+01 : f64) : f64
    %3 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %4 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %5 = llvm.mlir.constant(42 : si64) : i64
    %6 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %7 = llvm.mlir.constant(0 : index) : i64
    %8 = llvm.mlir.constant(512 : index) : i64
    %9 = llvm.mlir.constant(1 : index) : i64
    %10 = llvm.mlir.constant(140729106687144 : ui64) : i64
    %11 = llvm.mlir.constant(1 : i64) : i64
    %12 = llvm.alloca %11 x !llvm.ptr<i1> : (i64) -> !llvm.ptr<ptr<i1>>
    %13 = llvm.mlir.null : !llvm.ptr<i1>
    llvm.store %13, %12 : !llvm.ptr<ptr<i1>>
    llvm.call @_createDaphneContext__DaphneContext__uint64_t(%12, %10) : (!llvm.ptr<ptr<i1>>, i64) -> ()
    %14 = llvm.load %12 : !llvm.ptr<ptr<i1>>
    %15 = llvm.mlir.constant(512 : index) : i64
    %16 = llvm.mlir.constant(512 : index) : i64
    %17 = llvm.mlir.constant(1 : index) : i64
    %18 = llvm.mlir.constant(262144 : index) : i64
    %19 = llvm.mlir.null : !llvm.ptr<f64>
    %20 = llvm.getelementptr %19[262144] : (!llvm.ptr<f64>) -> !llvm.ptr<f64>
    %21 = llvm.ptrtoint %20 : !llvm.ptr<f64> to i64
    %22 = llvm.call @malloc(%21) : (i64) -> !llvm.ptr<i8>
    %23 = llvm.bitcast %22 : !llvm.ptr<i8> to !llvm.ptr<f64>
    %24 = llvm.mlir.undef : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<2 x i64>, array<2 x i64>)>
    %25 = llvm.insertvalue %23, %24[0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<2 x i64>, array<2 x i64>)> 
    %26 = llvm.insertvalue %23, %25[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<2 x i64>, array<2 x i64>)> 
    %27 = llvm.mlir.constant(0 : index) : i64
    %28 = llvm.insertvalue %27, %26[2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<2 x i64>, array<2 x i64>)> 
    %29 = llvm.insertvalue %15, %28[3, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<2 x i64>, array<2 x i64>)> 
    %30 = llvm.insertvalue %16, %29[3, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<2 x i64>, array<2 x i64>)> 
    %31 = llvm.insertvalue %16, %30[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<2 x i64>, array<2 x i64>)> 
    %32 = llvm.insertvalue %17, %31[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<2 x i64>, array<2 x i64>)> 
    %33 = llvm.ptrtoint %23 : !llvm.ptr<f64> to i64
    %34 = llvm.mlir.constant(1 : i64) : i64
    %35 = llvm.alloca %34 x !llvm.ptr<i1> : (i64) -> !llvm.ptr<ptr<i1>>
    %36 = llvm.mlir.null : !llvm.ptr<i1>
    llvm.store %36, %35 : !llvm.ptr<ptr<i1>>
    llvm.call @_convertMemRefToDenseMatrix__DenseMatrix_double__size_t__size_t__size_t__size_t__size_t__size_t(%35, %33, %7, %8, %8, %8, %9, %14) : (!llvm.ptr<ptr<i1>>, i64, i64, i64, i64, i64, i64, !llvm.ptr<i1>) -> ()
    %37 = llvm.load %35 : !llvm.ptr<ptr<i1>>
    %38 = llvm.mlir.constant(1 : i64) : i64
    llvm.call @_decRef__Structure(%37, %14) : (!llvm.ptr<i1>, !llvm.ptr<i1>) -> ()
    %39 = llvm.mlir.constant(1 : i64) : i64
    %40 = llvm.alloca %39 x !llvm.ptr<i1> : (i64) -> !llvm.ptr<ptr<i1>>
    %41 = llvm.mlir.null : !llvm.ptr<i1>
    llvm.store %41, %40 : !llvm.ptr<ptr<i1>>
    llvm.call @_randMatrix__DenseMatrix_double__size_t__size_t__double__double__double__int64_t(%40, %0, %0, %2, %3, %4, %5, %14) : (!llvm.ptr<ptr<i1>>, i64, i64, f64, f64, f64, i64, !llvm.ptr<i1>) -> ()
    %42 = llvm.load %40 : !llvm.ptr<ptr<i1>>
    %43 = llvm.mlir.constant(1 : i64) : i64
    %44 = llvm.alloca %43 x !llvm.ptr<i1> : (i64) -> !llvm.ptr<ptr<i1>>
    %45 = llvm.mlir.null : !llvm.ptr<i1>
    llvm.store %45, %44 : !llvm.ptr<ptr<i1>>
    llvm.call @_randMatrix__DenseMatrix_double__size_t__size_t__double__double__double__int64_t(%44, %0, %0, %2, %3, %4, %1, %14) : (!llvm.ptr<ptr<i1>>, i64, i64, f64, f64, f64, i64, !llvm.ptr<i1>) -> ()
    %46 = llvm.load %44 : !llvm.ptr<ptr<i1>>
    %47 = llvm.mlir.constant(1 : i64) : i64
    %48 = llvm.alloca %47 x !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<2 x i64>, array<2 x i64>)> : (i64) -> !llvm.ptr<struct<(ptr<f64>, ptr<f64>, i64, array<2 x i64>, array<2 x i64>)>>
    llvm.call @_convertDenseMatrixToMemRef__StridedMemRefType_double_2__DenseMatrix_double(%48, %42, %14) : (!llvm.ptr<struct<(ptr<f64>, ptr<f64>, i64, array<2 x i64>, array<2 x i64>)>>, !llvm.ptr<i1>, !llvm.ptr<i1>) -> ()
    %49 = llvm.load %48 : !llvm.ptr<struct<(ptr<f64>, ptr<f64>, i64, array<2 x i64>, array<2 x i64>)>>
    %50 = llvm.mlir.constant(1 : i64) : i64
    llvm.call @_decRef__Structure(%42, %14) : (!llvm.ptr<i1>, !llvm.ptr<i1>) -> ()
    %51 = llvm.mlir.constant(1 : i64) : i64
    %52 = llvm.alloca %51 x !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<2 x i64>, array<2 x i64>)> : (i64) -> !llvm.ptr<struct<(ptr<f64>, ptr<f64>, i64, array<2 x i64>, array<2 x i64>)>>
    llvm.call @_convertDenseMatrixToMemRef__StridedMemRefType_double_2__DenseMatrix_double(%52, %46, %14) : (!llvm.ptr<struct<(ptr<f64>, ptr<f64>, i64, array<2 x i64>, array<2 x i64>)>>, !llvm.ptr<i1>, !llvm.ptr<i1>) -> ()
    %53 = llvm.load %52 : !llvm.ptr<struct<(ptr<f64>, ptr<f64>, i64, array<2 x i64>, array<2 x i64>)>>
    %54 = llvm.mlir.constant(1 : i64) : i64
    llvm.call @_decRef__Structure(%46, %14) : (!llvm.ptr<i1>, !llvm.ptr<i1>) -> ()
    llvm.br ^bb1(%7 : i64)
  ^bb1(%55: i64):  // 2 preds: ^bb0, ^bb5
    %56 = llvm.icmp "slt" %55, %8 : i64
    llvm.cond_br %56, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%7 : i64)
  ^bb3(%57: i64):  // 2 preds: ^bb2, ^bb4
    %58 = llvm.icmp "slt" %57, %8 : i64
    llvm.cond_br %58, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %59 = llvm.mlir.constant(512 : index) : i64
    %60 = llvm.mul %55, %59  : i64
    %61 = llvm.add %60, %57  : i64
    %62 = llvm.getelementptr %23[%61] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    llvm.store %6, %62 : !llvm.ptr<f64>
    %63 = llvm.add %57, %9  : i64
    llvm.br ^bb3(%63 : i64)
  ^bb5:  // pred: ^bb3
    %64 = llvm.add %55, %9  : i64
    llvm.br ^bb1(%64 : i64)
  ^bb6:  // pred: ^bb1
    llvm.br ^bb7(%7 : i64)
  ^bb7(%65: i64):  // 2 preds: ^bb6, ^bb14
    %66 = llvm.icmp "slt" %65, %8 : i64
    llvm.cond_br %66, ^bb8, ^bb15
  ^bb8:  // pred: ^bb7
    llvm.br ^bb9(%7 : i64)
  ^bb9(%67: i64):  // 2 preds: ^bb8, ^bb13
    %68 = llvm.icmp "slt" %67, %8 : i64
    llvm.cond_br %68, ^bb10, ^bb14
  ^bb10:  // pred: ^bb9
    llvm.br ^bb11(%7 : i64)
  ^bb11(%69: i64):  // 2 preds: ^bb10, ^bb12
    %70 = llvm.icmp "slt" %69, %8 : i64
    llvm.cond_br %70, ^bb12, ^bb13
  ^bb12:  // pred: ^bb11
    %71 = llvm.extractvalue %49[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<2 x i64>, array<2 x i64>)> 
    %72 = llvm.mlir.constant(512 : index) : i64
    %73 = llvm.mul %65, %72  : i64
    %74 = llvm.add %73, %69  : i64
    %75 = llvm.getelementptr %71[%74] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %76 = llvm.load %75 : !llvm.ptr<f64>
    %77 = llvm.extractvalue %53[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<2 x i64>, array<2 x i64>)> 
    %78 = llvm.mlir.constant(512 : index) : i64
    %79 = llvm.mul %69, %78  : i64
    %80 = llvm.add %79, %67  : i64
    %81 = llvm.getelementptr %77[%80] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %82 = llvm.load %81 : !llvm.ptr<f64>
    %83 = llvm.mlir.constant(512 : index) : i64
    %84 = llvm.mul %65, %83  : i64
    %85 = llvm.add %84, %67  : i64
    %86 = llvm.getelementptr %23[%85] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %87 = llvm.load %86 : !llvm.ptr<f64>
    %88 = llvm.intr.fma(%76, %82, %87)  : (f64, f64, f64) -> f64
    %89 = llvm.mlir.constant(512 : index) : i64
    %90 = llvm.mul %65, %89  : i64
    %91 = llvm.add %90, %67  : i64
    %92 = llvm.getelementptr %23[%91] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    llvm.store %88, %92 : !llvm.ptr<f64>
    %93 = llvm.add %69, %9  : i64
    llvm.br ^bb11(%93 : i64)
  ^bb13:  // pred: ^bb11
    %94 = llvm.add %67, %9  : i64
    llvm.br ^bb9(%94 : i64)
  ^bb14:  // pred: ^bb9
    %95 = llvm.add %65, %9  : i64
    llvm.br ^bb7(%95 : i64)
  ^bb15:  // pred: ^bb7
    %96 = llvm.mlir.constant(1 : i64) : i64
    llvm.call @_decRef__Structure(%46, %14) : (!llvm.ptr<i1>, !llvm.ptr<i1>) -> ()
    %97 = llvm.mlir.constant(1 : i64) : i64
    llvm.call @_decRef__Structure(%42, %14) : (!llvm.ptr<i1>, !llvm.ptr<i1>) -> ()
    %98 = llvm.mlir.constant(1 : i64) : i64
    llvm.call @_destroyDaphneContext(%14) : (!llvm.ptr<i1>) -> ()
    llvm.return
  }
}
