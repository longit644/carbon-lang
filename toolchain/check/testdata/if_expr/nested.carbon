// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

fn F(a: bool, b: bool, c: bool) -> i32 {
  return if a then if b then 1 else 2 else if c then 3 else 4;
}

// CHECK:STDOUT: --- nested.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Bool: type = fn_type @Bool [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Bool = struct_value () [template]
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %struct.2: Int32 = struct_value () [template]
// CHECK:STDOUT:   %F: type = fn_type @F [template]
// CHECK:STDOUT:   %struct.3: F = struct_value () [template]
// CHECK:STDOUT:   %.2: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %.3: i32 = int_literal 2 [template]
// CHECK:STDOUT:   %.4: i32 = int_literal 3 [template]
// CHECK:STDOUT:   %.5: i32 = int_literal 4 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .F = %F.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Bool = import_ref ir7, inst+2, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.2: Bool = import_ref ir7, inst+2, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.3: Bool = import_ref ir7, inst+2, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.4: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.2]
// CHECK:STDOUT:   %F.decl: F = fn_decl @F [template = constants.%struct.3] {
// CHECK:STDOUT:     %bool.make_type.loc7_9: init type = call constants.%struct.1() [template = bool]
// CHECK:STDOUT:     %.loc7_9.1: type = value_of_initializer %bool.make_type.loc7_9 [template = bool]
// CHECK:STDOUT:     %.loc7_9.2: type = converted %bool.make_type.loc7_9, %.loc7_9.1 [template = bool]
// CHECK:STDOUT:     %a.loc7_6.1: bool = param a
// CHECK:STDOUT:     @F.%a: bool = bind_name a, %a.loc7_6.1
// CHECK:STDOUT:     %bool.make_type.loc7_18: init type = call constants.%struct.1() [template = bool]
// CHECK:STDOUT:     %.loc7_18.1: type = value_of_initializer %bool.make_type.loc7_18 [template = bool]
// CHECK:STDOUT:     %.loc7_18.2: type = converted %bool.make_type.loc7_18, %.loc7_18.1 [template = bool]
// CHECK:STDOUT:     %b.loc7_15.1: bool = param b
// CHECK:STDOUT:     @F.%b: bool = bind_name b, %b.loc7_15.1
// CHECK:STDOUT:     %bool.make_type.loc7_27: init type = call constants.%struct.1() [template = bool]
// CHECK:STDOUT:     %.loc7_27.1: type = value_of_initializer %bool.make_type.loc7_27 [template = bool]
// CHECK:STDOUT:     %.loc7_27.2: type = converted %bool.make_type.loc7_27, %.loc7_27.1 [template = bool]
// CHECK:STDOUT:     %c.loc7_24.1: bool = param c
// CHECK:STDOUT:     @F.%c: bool = bind_name c, %c.loc7_24.1
// CHECK:STDOUT:     %int.make_type_32: init type = call constants.%struct.2() [template = i32]
// CHECK:STDOUT:     %.loc7_36.1: type = value_of_initializer %int.make_type_32 [template = i32]
// CHECK:STDOUT:     %.loc7_36.2: type = converted %int.make_type_32, %.loc7_36.1 [template = i32]
// CHECK:STDOUT:     @F.%return: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Bool() -> type = "bool.make_type";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F(%a: bool, %b: bool, %c: bool) -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %a.ref: bool = name_ref a, %a
// CHECK:STDOUT:   if %a.ref br !if.expr.then.loc8_10 else br !if.expr.else.loc8_10
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.then.loc8_10:
// CHECK:STDOUT:   %b.ref: bool = name_ref b, %b
// CHECK:STDOUT:   if %b.ref br !if.expr.then.loc8_20 else br !if.expr.else.loc8_20
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.then.loc8_20:
// CHECK:STDOUT:   %.loc8_30: i32 = int_literal 1 [template = constants.%.2]
// CHECK:STDOUT:   br !if.expr.result.loc8_20(%.loc8_30)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.else.loc8_20:
// CHECK:STDOUT:   %.loc8_37: i32 = int_literal 2 [template = constants.%.3]
// CHECK:STDOUT:   br !if.expr.result.loc8_20(%.loc8_37)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.result.loc8_20:
// CHECK:STDOUT:   %.loc8_20: i32 = block_arg !if.expr.result.loc8_20
// CHECK:STDOUT:   br !if.expr.result.loc8_10(%.loc8_20)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.else.loc8_10:
// CHECK:STDOUT:   %c.ref: bool = name_ref c, %c
// CHECK:STDOUT:   if %c.ref br !if.expr.then.loc8_44 else br !if.expr.else.loc8_44
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.then.loc8_44:
// CHECK:STDOUT:   %.loc8_54: i32 = int_literal 3 [template = constants.%.4]
// CHECK:STDOUT:   br !if.expr.result.loc8_44(%.loc8_54)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.else.loc8_44:
// CHECK:STDOUT:   %.loc8_61: i32 = int_literal 4 [template = constants.%.5]
// CHECK:STDOUT:   br !if.expr.result.loc8_44(%.loc8_61)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.result.loc8_44:
// CHECK:STDOUT:   %.loc8_44: i32 = block_arg !if.expr.result.loc8_44
// CHECK:STDOUT:   br !if.expr.result.loc8_10(%.loc8_44)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.result.loc8_10:
// CHECK:STDOUT:   %.loc8_10: i32 = block_arg !if.expr.result.loc8_10
// CHECK:STDOUT:   return %.loc8_10
// CHECK:STDOUT: }
// CHECK:STDOUT:
