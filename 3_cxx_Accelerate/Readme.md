# Accelerate

This project demonstrates using Swift/C++ interop, creating an executable and
a library. The executable is written in C++, calling into a Swift library,
which calls a sparse solver of the Accelerate library. 
## Requirements
 - Swift 5.9 or later
 - Clang 11 or Apple Clang shipped in Xcode 12 or newer
 - CMake 3.26 or later
 - Ninja

## Build

```sh
 $ mkdir build
 $ cd build
 $ cmake -G 'Ninja' ../
 $ ninja
```

## Run

Start in the build directory you created above. There is an executables under
`src/`. `src/accelerate_cpp` is a program written in C++ that sets up a matrix M
and a vector B and solves M * X = B

