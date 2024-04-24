//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors.
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import Accelerate

public struct Indices {
   var entries : [Int32] = []
 
   public init()
   {}

   public init( _ i: [Int32])
   {
      entries = i;
   }
   
   public func get(_ i : Int) -> Int32
   {
     return entries[i]
   }
 
   public mutating func push_back(_ x: Int32)
   {
     entries.append(x)
   }
 }

public struct Values {
   var entries : [Double] = []
 
   public init()
   {}

   public init(  values: [Double])
   {
      entries = values;
   }
   

   public init(_ size : Int , _ ignore: Int)
   {
     self.entries =  [Double] (repeating: 0.0, count: size)
   }
   
   public func get(_ i : Int) -> Double
   {
     return entries[i]
   }
 
   public mutating func push_back(_ x: Double)
   {
     entries.append(x)
   }
 }



public func solve(_ dimension : Int32, _ rowIndices : Indices, _ columnIndices: Indices, _ aValues: Values, _ bValues:  Values, _ solution : inout Values ) {
  isolve(dimension, rowIndices.entries, columnIndices.entries, aValues.entries, bValues.entries, &solution.entries)
}










public class Matrix {
  var dimension : Int32
  var A : SparseMatrix_Double
  var factorization : SparseOpaqueFactorization_Double
  
  public init( _ dimension : Int32, _ rowIndices: Indices, _ columnIndices: Indices, _ aValues: Values)
  {
    self.dimension = dimension
    A = SparseConvertFromCoordinate(dimension, dimension,
                                     aValues.entries.count, 1,
                                     SparseAttributes_t(),
                                     rowIndices.entries, columnIndices.entries,
                                     aValues.entries)
    // print( A)
    
    factorization = SparseFactor(SparseFactorizationQR, A)
  }


  deinit {
    SparseCleanup(A)
    SparseCleanup(factorization)
  }


  public func solve( _ bValues:  Values, _ solution : inout Values)
  {
    solution.entries = bValues.entries.map { $0 }


    /// Solve the system.
    solution.entries.withUnsafeMutableBufferPointer { sPtr in
      let xb = DenseVector_Double(count: dimension,
                                  data: sPtr.baseAddress!)
    
       SparseSolve(factorization, xb)
   }
 }
}



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




func test()
{
  /// Create the coefficient matrix _A_.
  let dimension : Int32 = 3
  let rowIndices: Indices =   Indices( [ 0,  1, 1,  2] )
  let columnIndices: Indices = Indices( [ 2,  0, 2,  1] )
  let aValues: Values =  Values(values: [10, 20, 5, 50] )
  /// Create the right-hand-side vector, _b_.
  let bValues: Values = Values(values: [30, 35, 100] )
  var solution: Values = Values(values: [ 0, 0, 0] )

  //let M : Matrix = Matrix(dimension, rowIndices, columnIndices, aValues)

  // M.solve(bValues, &solution)

   solve(dimension, rowIndices, columnIndices, aValues, bValues, &solution)

  print( solution.entries[0])
  print( solution.entries[1])
  print( solution.entries[2])
}


// test()
