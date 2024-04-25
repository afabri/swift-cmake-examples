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

#include "accelerate/accelerate-swift.h"
#include <iostream>

int main(int argc, char ** argv) {


  SwiftAccelerate::Indices rows = SwiftAccelerate::Indices::init();
  SwiftAccelerate::Indices cols = SwiftAccelerate::Indices::init();
  SwiftAccelerate::Values values = SwiftAccelerate::Values::init();
  SwiftAccelerate::Values B = SwiftAccelerate::Values::init();
  SwiftAccelerate::Values X = SwiftAccelerate::Values::init();

  rows.push_back(0);
  cols.push_back(2);
  values.push_back(10.0);

  rows.push_back(1);
  cols.push_back(0);
  values.push_back(20.0);

  rows.push_back(1);
  cols.push_back(2);
  values.push_back(5.0);

  rows.push_back(2);
  cols.push_back(1);
  values.push_back(50.0);

  B.push_back(30.0);
  B.push_back(35.0);
  B.push_back(100.0);

  X.push_back(0.0);
  X.push_back(0.0);
  X.push_back(0.0);

  SwiftAccelerate::solve(3, rows, cols, values, B, X);
  
  std::cout << X.get(0) << std::endl;
  std::cout << X.get(1) << std::endl;
  std::cout << X.get(2) << std::endl;


  std::cout << "Now use Matrix" << std::endl;

  SwiftAccelerate::Matrix M = SwiftAccelerate::Matrix::init(3, rows, cols, values);
  M.solve(B, X);
  std::cout << X.get(0) << std::endl;
  std::cout << X.get(1) << std::endl;
  std::cout << X.get(2) << std::endl;
  
  return 0;
}
