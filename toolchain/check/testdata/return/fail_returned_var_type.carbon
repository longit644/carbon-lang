// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

fn Mismatch() -> i32 {
  // CHECK:STDERR: fail_returned_var_type.carbon:[[@LINE+6]]:19: ERROR: Type `f64` of `returned var` does not match return type of enclosing function.
  // CHECK:STDERR:   returned var v: f64 = 0.0;
  // CHECK:STDERR:                   ^~~
  // CHECK:STDERR: fail_returned_var_type.carbon:[[@LINE-4]]:15: Return type of function is `i32`.
  // CHECK:STDERR: fn Mismatch() -> i32 {
  // CHECK:STDERR:               ^~~~~~
  returned var v: f64 = 0.0;
  return var;
}

// CHECK:STDOUT: --- fail_returned_var_type.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Int32 = struct_value () [template]
// CHECK:STDOUT:   %Mismatch: type = fn_type @Mismatch [template]
// CHECK:STDOUT:   %struct.2: Mismatch = struct_value () [template]
// CHECK:STDOUT:   %.2: i32 = int_literal 64 [template]
// CHECK:STDOUT:   %Float: type = fn_type @Float [template]
// CHECK:STDOUT:   %struct.3: Float = struct_value () [template]
// CHECK:STDOUT:   %.3: f64 = float_literal 0 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Mismatch = %Mismatch.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %Mismatch.decl: Mismatch = fn_decl @Mismatch [template = constants.%struct.2] {
// CHECK:STDOUT:     %int.make_type_32: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc7_18.1: type = value_of_initializer %int.make_type_32 [template = i32]
// CHECK:STDOUT:     %.loc7_18.2: type = converted %int.make_type_32, %.loc7_18.1 [template = i32]
// CHECK:STDOUT:     @Mismatch.%return: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.2: Float = import_ref ir3, inst+31, loaded [template = constants.%struct.3]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Mismatch() -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc14_19.1: i32 = int_literal 64 [template = constants.%.2]
// CHECK:STDOUT:   %float.make_type: init type = call constants.%struct.3(%.loc14_19.1) [template = f64]
// CHECK:STDOUT:   %.loc14_19.2: type = value_of_initializer %float.make_type [template = f64]
// CHECK:STDOUT:   %.loc14_19.3: type = converted %float.make_type, %.loc14_19.2 [template = f64]
// CHECK:STDOUT:   %v: f64 = bind_name v, <error>
// CHECK:STDOUT:   %.loc14_25: f64 = float_literal 0 [template = constants.%.3]
// CHECK:STDOUT:   assign <error>, <error>
// CHECK:STDOUT:   return <error>
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Float(%size: i32) -> type = "float.make_type";
// CHECK:STDOUT:
