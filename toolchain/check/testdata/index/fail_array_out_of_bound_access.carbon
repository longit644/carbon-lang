// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

var a: [i32; 1] = (12,);
// CHECK:STDERR: fail_array_out_of_bound_access.carbon:[[@LINE+3]]:16: ERROR: Array index `1` is past the end of type `[i32; 1]`.
// CHECK:STDERR: var b: i32 = a[1];
// CHECK:STDERR:                ^
var b: i32 = a[1];

// CHECK:STDOUT: --- fail_array_out_of_bound_access.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct: Int32 = struct_value () [template]
// CHECK:STDOUT:   %.2: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %.3: type = array_type %.2, i32 [template]
// CHECK:STDOUT:   %.4: type = ptr_type [i32; 1] [template]
// CHECK:STDOUT:   %.5: i32 = int_literal 12 [template]
// CHECK:STDOUT:   %.6: type = tuple_type (i32) [template]
// CHECK:STDOUT:   %.7: i32 = int_literal 0 [template]
// CHECK:STDOUT:   %array: [i32; 1] = tuple_value (%.5) [template]
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
// CHECK:STDOUT:   %int.make_type_32.loc7: init type = call constants.%struct() [template = i32]
// CHECK:STDOUT:   %.loc7_14: i32 = int_literal 1 [template = constants.%.2]
// CHECK:STDOUT:   %.loc7_9.1: type = value_of_initializer %int.make_type_32.loc7 [template = i32]
// CHECK:STDOUT:   %.loc7_9.2: type = converted %int.make_type_32.loc7, %.loc7_9.1 [template = i32]
// CHECK:STDOUT:   %.loc7_15: type = array_type %.loc7_14, i32 [template = constants.%.3]
// CHECK:STDOUT:   %a.var: ref [i32; 1] = var a
// CHECK:STDOUT:   %a: ref [i32; 1] = bind_name a, %a.var
// CHECK:STDOUT:   %import_ref.2: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct]
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
// CHECK:STDOUT:   %.loc7_20: i32 = int_literal 12 [template = constants.%.5]
// CHECK:STDOUT:   %.loc7_23.1: (i32,) = tuple_literal (%.loc7_20)
// CHECK:STDOUT:   %.loc7_23.2: i32 = int_literal 0 [template = constants.%.7]
// CHECK:STDOUT:   %.loc7_23.3: ref i32 = array_index file.%a.var, %.loc7_23.2
// CHECK:STDOUT:   %.loc7_23.4: init i32 = initialize_from %.loc7_20 to %.loc7_23.3 [template = constants.%.5]
// CHECK:STDOUT:   %.loc7_23.5: init [i32; 1] = array_init (%.loc7_23.4) to file.%a.var [template = constants.%array]
// CHECK:STDOUT:   %.loc7_24: init [i32; 1] = converted %.loc7_23.1, %.loc7_23.5 [template = constants.%array]
// CHECK:STDOUT:   assign file.%a.var, %.loc7_24
// CHECK:STDOUT:   %a.ref: ref [i32; 1] = name_ref a, file.%a
// CHECK:STDOUT:   %.loc11_16: i32 = int_literal 1 [template = constants.%.2]
// CHECK:STDOUT:   %.loc11_17.1: ref i32 = array_index %a.ref, %.loc11_16 [template = <error>]
// CHECK:STDOUT:   %.loc11_17.2: i32 = bind_value %.loc11_17.1
// CHECK:STDOUT:   assign file.%b.var, %.loc11_17.2
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
