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

import Fibonacci


public struct Indices {
   var entries : [Int32] = []
 
   public init()
   {}
 
   public mutating func push_back(_ x: Int32)
   {
     entries.append(x)
   }
}


public class Matrix {
  var dimension : Int32

public init( _ rowIndices: Indices )
  {
    dimension = 0
  }
}


public func fibonacciSwift(_ x: CInt) -> CInt {
  print("x [swift]: \(x)")
  if x <= 1 {
    return 1
  }
  return fibonacci_cpp(x - 1) + fibonacci_cpp(x - 2)
}
