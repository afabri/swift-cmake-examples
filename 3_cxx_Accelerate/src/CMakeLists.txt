# This source file is part of the Swift open source project
#
# Copyright (c) 2023 Apple Inc. and the Swift project authors.
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See https://swift.org/LICENSE.txt for license information

find_package(CGAL REQUIRED)

include_directories( BEFORE /Users/geometryfactory//afabri/swift-cmake-examples/3_cxx_Accelerate/build/lib/acceleRATE/include/ )

add_executable(cgal_accelerate cgal_accelerate.cpp)
target_link_libraries( cgal_accelerate PRIVATE CGAL::CGAL accelerate )

add_executable(discrete_authalic discrete_authalic.cpp )
target_link_libraries(discrete_authalic PRIVATE CGAL::CGAL accelerate )

add_executable(accelerate_cpp accelerate.cpp)
target_link_libraries(accelerate_cpp PRIVATE accelerate)



