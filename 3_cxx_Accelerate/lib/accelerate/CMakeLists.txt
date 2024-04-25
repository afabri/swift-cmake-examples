# This source file is part of the Swift open source project
#
# Copyright (c) 2023 Apple Inc. and the Swift project authors.
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See https://swift.org/LICENSE.txt for license information

add_library(accelerate STATIC accelerate.swift )
set_target_properties(accelerate PROPERTIES Swift_MODULE_NAME "SwiftAccelerate")
target_compile_options(accelerate PUBLIC
  "$<$<COMPILE_LANGUAGE:Swift>:-cxx-interoperability-mode=default>")

# Generate a C++ header from Swift sources. This is automatically added to the
# accelerate target. The target will regenerate the header file when any of the
# Swift sources change. Clang detects that the C++ file depends on the header,
# and tells Ninja about this dependency in the depfile.
#
# This function is implemented in cmake/modules/AddSwift.cmake.
_swift_generate_cxx_header(accelerate
  accelerate/accelerate-swift.h
  SEARCH_PATHS "${ACCELERATE_INCLUDE_DIR}")



