// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE


fn Main() -> (i32, i32) {
  return (15, 35);
}

// CHECK:STDOUT: --- tuple.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Int32 = struct_value () [template]
// CHECK:STDOUT:   %.2: type = tuple_type (type, type) [template]
// CHECK:STDOUT:   %.3: type = tuple_type (i32, i32) [template]
// CHECK:STDOUT:   %Main: type = fn_type @Main [template]
// CHECK:STDOUT:   %struct.2: Main = struct_value () [template]
// CHECK:STDOUT:   %.4: type = ptr_type (i32, i32) [template]
// CHECK:STDOUT:   %.5: i32 = int_literal 15 [template]
// CHECK:STDOUT:   %.6: i32 = int_literal 35 [template]
// CHECK:STDOUT:   %tuple: (i32, i32) = tuple_value (%.5, %.6) [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Main = %Main.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.2: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %Main.decl: Main = fn_decl @Main [template = constants.%struct.2] {
// CHECK:STDOUT:     %int.make_type_32.loc8_15: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %int.make_type_32.loc8_20: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc8_23.1: (type, type) = tuple_literal (%int.make_type_32.loc8_15, %int.make_type_32.loc8_20)
// CHECK:STDOUT:     %.loc8_23.2: type = value_of_initializer %int.make_type_32.loc8_15 [template = i32]
// CHECK:STDOUT:     %.loc8_23.3: type = converted %int.make_type_32.loc8_15, %.loc8_23.2 [template = i32]
// CHECK:STDOUT:     %.loc8_23.4: type = value_of_initializer %int.make_type_32.loc8_20 [template = i32]
// CHECK:STDOUT:     %.loc8_23.5: type = converted %int.make_type_32.loc8_20, %.loc8_23.4 [template = i32]
// CHECK:STDOUT:     %.loc8_23.6: type = converted %.loc8_23.1, constants.%.3 [template = constants.%.3]
// CHECK:STDOUT:     @Main.%return: ref (i32, i32) = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Main() -> %return: (i32, i32) {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc9_11: i32 = int_literal 15 [template = constants.%.5]
// CHECK:STDOUT:   %.loc9_15: i32 = int_literal 35 [template = constants.%.6]
// CHECK:STDOUT:   %.loc9_17.1: (i32, i32) = tuple_literal (%.loc9_11, %.loc9_15)
// CHECK:STDOUT:   %.loc9_17.2: ref i32 = tuple_access %return, element0
// CHECK:STDOUT:   %.loc9_17.3: init i32 = initialize_from %.loc9_11 to %.loc9_17.2 [template = constants.%.5]
// CHECK:STDOUT:   %.loc9_17.4: ref i32 = tuple_access %return, element1
// CHECK:STDOUT:   %.loc9_17.5: init i32 = initialize_from %.loc9_15 to %.loc9_17.4 [template = constants.%.6]
// CHECK:STDOUT:   %.loc9_17.6: init (i32, i32) = tuple_init (%.loc9_17.3, %.loc9_17.5) to %return [template = constants.%tuple]
// CHECK:STDOUT:   %.loc9_18: init (i32, i32) = converted %.loc9_17.1, %.loc9_17.6 [template = constants.%tuple]
// CHECK:STDOUT:   return %.loc9_18 to %return
// CHECK:STDOUT: }
// CHECK:STDOUT:
