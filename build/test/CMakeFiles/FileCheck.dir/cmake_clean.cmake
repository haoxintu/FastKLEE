file(REMOVE_RECURSE
  "../bin/FileCheck"
  "../bin/FileCheck.pdb"
  "ArrayOpt/Output"
  "CXX/Output"
  "CXX/symex/Output"
  "CXX/symex/libc++/Output"
  "Concrete/Output"
  "Coverage/Output"
  "Dogfood/Output"
  "Expr/Lexer/Output"
  "Expr/Output"
  "Expr/Parser/Output"
  "Feature/Output"
  "Intrinsics/Output"
  "Merging/Output"
  "Programs/Output"
  "Replay/Output"
  "Replay/klee-replay/Output"
  "Replay/libkleeruntest/Output"
  "Runtime/FreeStanding/Output"
  "Runtime/Output"
  "Runtime/POSIX/Output"
  "Runtime/POSIX/SELinux/Output"
  "Runtime/Uclibc/Output"
  "Solver/Output"
  "VectorInstructions/Output"
  "regression/Output"
  "CMakeFiles/FileCheck.dir/FileCheck.cpp.o"
)

# Per-language clean rules from dependency scanning.
foreach(lang CXX)
  include(CMakeFiles/FileCheck.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
