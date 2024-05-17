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

   public init(_ size : Int , _ ignore: Int)
   {
     self.entries =  [Double] (repeating: 0.0, count: size)
   }
   
   public mutating func set(_ i : Int, _ d : Double)
   {
    entries[i] = d;
   }
   
   public func get(_ i : Int) -> Double
   {
     return entries[i]
   }

   public mutating func push_back(_ x: Double)
   {
     entries.append(x)
   }
   public func size() -> Int
   {
     return entries.count;
   }
 }



public func solve(_ dimension : Int32, _ rowIndices : inout Indices, _ columnIndices: inout Indices, _ aValues: inout Values, _ bValues:  inout Values, _ solution : inout Values ) {
  isolve(dimension, rowIndices.entries, columnIndices.entries, aValues.entries, bValues.entries, &solution.entries)
}





public struct Matrix {
  var dimension : Int32
  var A : SparseMatrix_Double
  var factorization : SparseOpaqueFactorization_Double

  public init()
  {
    dimension = 0
    A = SparseMatrix_Double()
    factorization = SparseOpaqueFactorization_Double()
  }

  public mutating func initialize( _ dimension : Int32, _ rowIndices: inout Indices, _ columnIndices: inout Indices, _ aValues: inout Values)
  {
    self.dimension = dimension
    A = SparseConvertFromCoordinate(dimension, dimension,
                                     aValues.entries.count, 1,
                                     SparseAttributes_t(),
                                     rowIndices.entries, columnIndices.entries,
                                     aValues.entries)
    
    factorization = SparseFactor(SparseFactorizationQR, A)
  }


  // deinit
  // {}


  public func solve( _ bValues:  inout Values, _ solution : inout Values)
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

