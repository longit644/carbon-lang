// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

var a: (i32, i32) = (12, 6);
// CHECK:STDERR: fail_tuple_out_of_bound_access.carbon:[[@LINE+3]]:14: ERROR: Tuple element index `2` is past the end of type `(i32, i32)`.
// CHECK:STDERR: var b: i32 = a[2];
// CHECK:STDERR:              ^~~~
var b: i32 = a[2];

// CHECK:STDOUT: --- fail_tuple_out_of_bound_access.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct: Int32 = struct_value () [template]
// CHECK:STDOUT:   %.2: type = tuple_type (type, type) [template]
// CHECK:STDOUT:   %.3: type = tuple_type (i32, i32) [template]
// CHECK:STDOUT:   %.4: type = ptr_type (i32, i32) [template]
// CHECK:STDOUT:   %.5: i32 = int_literal 12 [template]
// CHECK:STDOUT:   %.6: i32 = int_literal 6 [template]
// CHECK:STDOUT:   %tuple: (i32, i32) = tuple_value (%.5, %.6) [template]
// CHECK:STDOUT:   %.7: i32 = int_literal 2 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .a = %a
// CHECK:STDOUT:     .b = %b
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct]
// CHECK:STDOUT:   %int.make_type_32.loc7_9: init type = call constants.%struct() [template = i32]
// CHECK:STDOUT:   %import_ref.2: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct]
// CHECK:STDOUT:   %int.make_type_32.loc7_14: init type = call constants.%struct() [template = i32]
// CHECK:STDOUT:   %.loc7_17.1: (type, type) = tuple_literal (%int.make_type_32.loc7_9, %int.make_type_32.loc7_14)
// CHECK:STDOUT:   %.loc7_17.2: type = value_of_initializer %int.make_type_32.loc7_9 [template = i32]
// CHECK:STDOUT:   %.loc7_17.3: type = converted %int.make_type_32.loc7_9, %.loc7_17.2 [template = i32]
// CHECK:STDOUT:   %.loc7_17.4: type = value_of_initializer %int.make_type_32.loc7_14 [template = i32]
// CHECK:STDOUT:   %.loc7_17.5: type = converted %int.make_type_32.loc7_14, %.loc7_17.4 [template = i32]
// CHECK:STDOUT:   %.loc7_17.6: type = converted %.loc7_17.1, constants.%.3 [template = constants.%.3]
// CHECK:STDOUT:   %a.var: ref (i32, i32) = var a
// CHECK:STDOUT:   %a: ref (i32, i32) = bind_name a, %a.var
// CHECK:STDOUT:   %import_ref.3: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct]
// CHECK:STDOUT:   %int.make_type_32.loc11: init type = call constants.%struct() [template = i32]
// CHECK:STDOUT:   %.loc11_8.1: type = value_of_initializer %int.make_type_32.loc11 [template = i32]
// CHECK:STDOUT:   %.loc11_8.2: type = converted %int.make_type_32.loc11, %.loc11_8.1 [template = i32]
// CHECK:STDOUT:   %b.var: ref i32 = var b
// CHECK:STDOUT:   %b: ref i32 = bind_name b, %b.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @__global_init() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc7_22: i32 = int_literal 12 [template = constants.%.5]
// CHECK:STDOUT:   %.loc7_26: i32 = int_literal 6 [template = constants.%.6]
// CHECK:STDOUT:   %.loc7_27.1: (i32, i32) = tuple_literal (%.loc7_22, %.loc7_26)
// CHECK:STDOUT:   %.loc7_27.2: ref i32 = tuple_access file.%a.var, element0
// CHECK:STDOUT:   %.loc7_27.3: init i32 = initialize_from %.loc7_22 to %.loc7_27.2 [template = constants.%.5]
// CHECK:STDOUT:   %.loc7_27.4: ref i32 = tuple_access file.%a.var, element1
// CHECK:STDOUT:   %.loc7_27.5: init i32 = initialize_from %.loc7_26 to %.loc7_27.4 [template = constants.%.6]
// CHECK:STDOUT:   %.loc7_27.6: init (i32, i32) = tuple_init (%.loc7_27.3, %.loc7_27.5) to file.%a.var [template = constants.%tuple]
// CHECK:STDOUT:   %.loc7_28: init (i32, i32) = converted %.loc7_27.1, %.loc7_27.6 [template = constants.%tuple]
// CHECK:STDOUT:   assign file.%a.var, %.loc7_28
// CHECK:STDOUT:   %a.ref: ref (i32, i32) = name_ref a, file.%a
// CHECK:STDOUT:   %.loc11_16: i32 = int_literal 2 [template = constants.%.7]
// CHECK:STDOUT:   %.loc11_17: ref <error> = tuple_index %a.ref, <error>
// CHECK:STDOUT:   assign file.%b.var, <error>
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
