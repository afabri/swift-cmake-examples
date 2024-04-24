


/*
import Accelerate



func isolve(_ dimension : Int32, _ rowIndices: [Int32], _ columnIndices: [Int32], _ aValues: [Double], _ bValues:  [Double], _ solution : inout [Double] ) {


let A = SparseConvertFromCoordinate(dimension, dimension,
                                    aValues.count, 1,
                                    SparseAttributes_t(),
                                    rowIndices, columnIndices,
                                    aValues)
/// Factorize _A_.
let factorization = SparseFactor(SparseFactorizationQR, A)

defer {
    SparseCleanup(A)
    SparseCleanup(factorization)
}

solution = bValues.map { $0 }

/// Solve the system.
solution.withUnsafeMutableBufferPointer { sPtr in
    let xb = DenseVector_Double(count: dimension,
                               data: sPtr.baseAddress!)
    
    SparseSolve(factorization, xb)
}



}

func wrapper()
{
/// Create the coefficient matrix _A_.
let dimension : Int32 = 3
let rowIndices: [Int32] =    [ 0,  1, 1,  2]
let columnIndices: [Int32] = [ 2,  0, 2,  1]
let aValues: [Double] =      [10, 20, 5, 50]
/// Create the right-hand-side vector, _b_.
let bValues: [Double] = [30, 35, 100]
var solution: [Double] = [ 0, 0, 0]

isolve(dimension, rowIndices, columnIndices, aValues, bValues, &solution)
print( solution[0])
print( solution[1])
print( solution[2])

}


wrapper()
*/