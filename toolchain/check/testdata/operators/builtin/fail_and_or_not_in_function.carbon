// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// TODO: Make this a compile-time function.
fn F(b: bool) -> type {
  return if b then i32 else f64;
}

// TODO: Short-circuit operators should be permitted outside functions.
// CHECK:STDERR: fail_and_or_not_in_function.carbon:[[@LINE+12]]:11: ERROR: Cannot evaluate type expression.
// CHECK:STDERR: var and_: F(true and true);
// CHECK:STDERR:           ^~~~~~~~~~~~~~~~
// CHECK:STDERR:
// CHECK:STDERR: fail_and_or_not_in_function.carbon:[[@LINE+8]]:13: ERROR: Semantics TODO: `Control flow expressions are currently only supported inside functions.`.
// CHECK:STDERR: var and_: F(true and true);
// CHECK:STDERR:             ^~~~~~~~
// CHECK:STDERR:
// CHECK:STDERR: fail_and_or_not_in_function.carbon:[[@LINE+4]]:13: ERROR: Semantics TODO: `Control flow expressions are currently only supported inside functions.`.
// CHECK:STDERR: var and_: F(true and true);
// CHECK:STDERR:             ^~~~~~~~~~~~~
// CHECK:STDERR:
var and_: F(true and true);

// CHECK:STDERR: fail_and_or_not_in_function.carbon:[[@LINE+11]]:10: ERROR: Cannot evaluate type expression.
// CHECK:STDERR: var or_: F(true or true);
// CHECK:STDERR:          ^~~~~~~~~~~~~~~
// CHECK:STDERR:
// CHECK:STDERR: fail_and_or_not_in_function.carbon:[[@LINE+7]]:12: ERROR: Semantics TODO: `Control flow expressions are currently only supported inside functions.`.
// CHECK:STDERR: var or_: F(true or true);
// CHECK:STDERR:            ^~~~~~~
// CHECK:STDERR:
// CHECK:STDERR: fail_and_or_not_in_function.carbon:[[@LINE+3]]:12: ERROR: Semantics TODO: `Control flow expressions are currently only supported inside functions.`.
// CHECK:STDERR: var or_: F(true or true);
// CHECK:STDERR:            ^~~~~~~~~~~~
var or_: F(true or true);

// CHECK:STDOUT: --- fail_and_or_not_in_function.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Bool: type = fn_type @Bool [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Bool = struct_value () [template]
// CHECK:STDOUT:   %F: type = fn_type @F [template]
// CHECK:STDOUT:   %struct.2: F = struct_value () [template]
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %struct.3: Int32 = struct_value () [template]
// CHECK:STDOUT:   %.2: i32 = int_literal 64 [template]
// CHECK:STDOUT:   %Float: type = fn_type @Float [template]
// CHECK:STDOUT:   %struct.4: Float = struct_value () [template]
// CHECK:STDOUT:   %.3: bool = bool_literal true [template]
// CHECK:STDOUT:   %.4: bool = bool_literal false [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   %.loc38_17: bool = block_arg <unexpected instblockref block20> [template = constants.%.3]
// CHECK:STDOUT:   %F.call: init type = call <unexpected instref inst+59>(%.loc38_17)
// CHECK:STDOUT:   %.loc38_24.1: type = value_of_initializer %F.call
// CHECK:STDOUT:   %.loc38_24.2: type = converted %F.call, %.loc38_24.1
// CHECK:STDOUT:   %or_.var: ref <error> = var or_
// CHECK:STDOUT:   %or_: ref <error> = bind_name or_, %or_.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Bool() -> type = "bool.make_type";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F(%b: bool) -> type {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %b.ref: bool = name_ref b, %b
// CHECK:STDOUT:   if %b.ref br !if.expr.then else br !if.expr.else
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.then:
// CHECK:STDOUT:   %int.make_type_32: init type = call constants.%struct.3() [template = i32]
// CHECK:STDOUT:   %.loc9_20.1: type = value_of_initializer %int.make_type_32 [template = i32]
// CHECK:STDOUT:   %.loc9_20.2: type = converted %int.make_type_32, %.loc9_20.1 [template = i32]
// CHECK:STDOUT:   br !if.expr.result(%.loc9_20.2)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.else:
// CHECK:STDOUT:   %.loc9_29: i32 = int_literal 64 [template = constants.%.2]
// CHECK:STDOUT:   %float.make_type: init type = call constants.%struct.4(%.loc9_29) [template = f64]
// CHECK:STDOUT:   %.loc9_24.1: type = value_of_initializer %float.make_type [template = f64]
// CHECK:STDOUT:   %.loc9_24.2: type = converted %float.make_type, %.loc9_24.1 [template = f64]
// CHECK:STDOUT:   br !if.expr.result(%.loc9_24.2)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.result:
// CHECK:STDOUT:   %.loc9_10: type = block_arg !if.expr.result
// CHECK:STDOUT:   return %.loc9_10
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Float(%size: i32) -> type = "float.make_type";
// CHECK:STDOUT:
