// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// CHECK:STDERR: fail_field_name_mismatch.carbon:[[@LINE+4]]:20: ERROR: Missing value for field `a` in struct initialization.
// CHECK:STDERR: var x: {.a: i32} = {.b = 1};
// CHECK:STDERR:                    ^~~~~~~~
// CHECK:STDERR:
var x: {.a: i32} = {.b = 1};

// CHECK:STDERR: fail_field_name_mismatch.carbon:[[@LINE+3]]:20: ERROR: Cannot convert from struct type `{.a: i32}` to `{.b: i32}`: missing field `b` in source type.
// CHECK:STDERR: var y: {.b: i32} = x;
// CHECK:STDERR:                    ^
var y: {.b: i32} = x;

// CHECK:STDOUT: --- fail_field_name_mismatch.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct: Int32 = struct_value () [template]
// CHECK:STDOUT:   %.2: type = struct_type {.a: i32} [template]
// CHECK:STDOUT:   %.3: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %.4: type = struct_type {.b: i32} [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .x = %x
// CHECK:STDOUT:     .y = %y
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct]
// CHECK:STDOUT:   %int.make_type_32.loc11: init type = call constants.%struct() [template = i32]
// CHECK:STDOUT:   %.loc11_13.1: type = value_of_initializer %int.make_type_32.loc11 [template = i32]
// CHECK:STDOUT:   %.loc11_13.2: type = converted %int.make_type_32.loc11, %.loc11_13.1 [template = i32]
// CHECK:STDOUT:   %.loc11_16: type = struct_type {.a: i32} [template = constants.%.2]
// CHECK:STDOUT:   %x.var: ref {.a: i32} = var x
// CHECK:STDOUT:   %x: ref {.a: i32} = bind_name x, %x.var
// CHECK:STDOUT:   %import_ref.2: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct]
// CHECK:STDOUT:   %int.make_type_32.loc16: init type = call constants.%struct() [template = i32]
// CHECK:STDOUT:   %.loc16_13.1: type = value_of_initializer %int.make_type_32.loc16 [template = i32]
// CHECK:STDOUT:   %.loc16_13.2: type = converted %int.make_type_32.loc16, %.loc16_13.1 [template = i32]
// CHECK:STDOUT:   %.loc16_16: type = struct_type {.b: i32} [template = constants.%.4]
// CHECK:STDOUT:   %y.var: ref {.b: i32} = var y
// CHECK:STDOUT:   %y: ref {.b: i32} = bind_name y, %y.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @__global_init() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc11_26: i32 = int_literal 1 [template = constants.%.3]
// CHECK:STDOUT:   %.loc11_27: {.b: i32} = struct_literal (%.loc11_26)
// CHECK:STDOUT:   assign file.%x.var, <error>
// CHECK:STDOUT:   %x.ref: ref {.a: i32} = name_ref x, file.%x
// CHECK:STDOUT:   assign file.%y.var, <error>
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
