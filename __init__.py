import cppyy
root="/usr/local/site-packages/ortools_space_planner_pypy"
cppyy.add_include_path(f'{root}/dependencies/sources/abseil-cpp-bf29470/')
cppyy.add_include_path(f'{root}/')
cppyy.add_include_path(f'{root}/ortools/gen/')
cppyy.add_include_path(f'{root}/dependencies/install/include/')
cppyy.include(f'{root}/ortools/constraint_solver/constraint_solver.h')
cppyy.load_library(f'{root}/lib/libortools.so')
from cppyy.gbl import operations_research
#solver = operations_research.Solver('SpacePlanner')
