// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// CHECK:STDERR: fail_too_few_values.carbon:[[@LINE+3]]:29: ERROR: Cannot initialize struct with 2 field(s) from struct with 1 field(s).
// CHECK:STDERR: var x: {.a: i32, .b: i32} = {.a = 1};
// CHECK:STDERR:                             ^~~~~~~~
var x: {.a: i32, .b: i32} = {.a = 1};

// CHECK:STDOUT: --- fail_too_few_values.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct: Int32 = struct_value () [template]
// CHECK:STDOUT:   %.2: type = struct_type {.a: i32, .b: i32} [template]
// CHECK:STDOUT:   %.3: type = ptr_type {.a: i32, .b: i32} [template]
// CHECK:STDOUT:   %.4: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %.5: type = struct_type {.a: i32} [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .x = %x
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct]
// CHECK:STDOUT:   %int.make_type_32.loc10_13: init type = call constants.%struct() [template = i32]
// CHECK:STDOUT:   %.loc10_13.1: type = value_of_initializer %int.make_type_32.loc10_13 [template = i32]
// CHECK:STDOUT:   %.loc10_13.2: type = converted %int.make_type_32.loc10_13, %.loc10_13.1 [template = i32]
// CHECK:STDOUT:   %import_ref.2: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct]
// CHECK:STDOUT:   %int.make_type_32.loc10_22: init type = call constants.%struct() [template = i32]
// CHECK:STDOUT:   %.loc10_22.1: type = value_of_initializer %int.make_type_32.loc10_22 [template = i32]
// CHECK:STDOUT:   %.loc10_22.2: type = converted %int.make_type_32.loc10_22, %.loc10_22.1 [template = i32]
// CHECK:STDOUT:   %.loc10_25: type = struct_type {.a: i32, .b: i32} [template = constants.%.2]
// CHECK:STDOUT:   %x.var: ref {.a: i32, .b: i32} = var x
// CHECK:STDOUT:   %x: ref {.a: i32, .b: i32} = bind_name x, %x.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @__global_init() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc10_35: i32 = int_literal 1 [template = constants.%.4]
// CHECK:STDOUT:   %.loc10_36: {.a: i32} = struct_literal (%.loc10_35)
// CHECK:STDOUT:   assign file.%x.var, <error>
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
