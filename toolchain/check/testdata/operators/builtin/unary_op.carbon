// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

fn Not(b: bool) -> bool {
  return not b;
}

let not_true: bool = not true;
let not_false: bool = not false;

fn Constant() {
  var a: if not true then bool else () = ();
  var b: if not false then bool else () = true;
}

// CHECK:STDOUT: --- unary_op.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Bool: type = fn_type @Bool [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Bool = struct_value () [template]
// CHECK:STDOUT:   %Not: type = fn_type @Not [template]
// CHECK:STDOUT:   %struct.2: Not = struct_value () [template]
// CHECK:STDOUT:   %.2: bool = bool_literal true [template]
// CHECK:STDOUT:   %.3: bool = bool_literal false [template]
// CHECK:STDOUT:   %Constant: type = fn_type @Constant [template]
// CHECK:STDOUT:   %struct.3: Constant = struct_value () [template]
// CHECK:STDOUT:   %tuple: () = tuple_value () [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Not = %Not.decl
// CHECK:STDOUT:     .Constant = %Constant.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Bool = import_ref ir7, inst+2, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.2: Bool = import_ref ir7, inst+2, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %Not.decl: Not = fn_decl @Not [template = constants.%struct.2] {
// CHECK:STDOUT:     %bool.make_type.loc7_11: init type = call constants.%struct.1() [template = bool]
// CHECK:STDOUT:     %.loc7_11.1: type = value_of_initializer %bool.make_type.loc7_11 [template = bool]
// CHECK:STDOUT:     %.loc7_11.2: type = converted %bool.make_type.loc7_11, %.loc7_11.1 [template = bool]
// CHECK:STDOUT:     %b.loc7_8.1: bool = param b
// CHECK:STDOUT:     @Not.%b: bool = bind_name b, %b.loc7_8.1
// CHECK:STDOUT:     %bool.make_type.loc7_20: init type = call constants.%struct.1() [template = bool]
// CHECK:STDOUT:     %.loc7_20.1: type = value_of_initializer %bool.make_type.loc7_20 [template = bool]
// CHECK:STDOUT:     %.loc7_20.2: type = converted %bool.make_type.loc7_20, %.loc7_20.1 [template = bool]
// CHECK:STDOUT:     @Not.%return: ref bool = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.3: Bool = import_ref ir7, inst+2, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %bool.make_type.loc11: init type = call constants.%struct.1() [template = bool]
// CHECK:STDOUT:   %.loc11_15.1: type = value_of_initializer %bool.make_type.loc11 [template = bool]
// CHECK:STDOUT:   %.loc11_15.2: type = converted %bool.make_type.loc11, %.loc11_15.1 [template = bool]
// CHECK:STDOUT:   %.loc11_26: bool = bool_literal true [template = constants.%.2]
// CHECK:STDOUT:   %.loc11_22: bool = not %.loc11_26 [template = constants.%.3]
// CHECK:STDOUT:   %not_true: bool = bind_name not_true, %.loc11_22
// CHECK:STDOUT:   %import_ref.4: Bool = import_ref ir7, inst+2, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %bool.make_type.loc12: init type = call constants.%struct.1() [template = bool]
// CHECK:STDOUT:   %.loc12_16.1: type = value_of_initializer %bool.make_type.loc12 [template = bool]
// CHECK:STDOUT:   %.loc12_16.2: type = converted %bool.make_type.loc12, %.loc12_16.1 [template = bool]
// CHECK:STDOUT:   %.loc12_27: bool = bool_literal false [template = constants.%.3]
// CHECK:STDOUT:   %.loc12_23: bool = not %.loc12_27 [template = constants.%.2]
// CHECK:STDOUT:   %not_false: bool = bind_name not_false, %.loc12_23
// CHECK:STDOUT:   %Constant.decl: Constant = fn_decl @Constant [template = constants.%struct.3] {}
// CHECK:STDOUT:   %import_ref.5: Bool = import_ref ir7, inst+2, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.6: Bool = import_ref ir7, inst+2, loaded [template = constants.%struct.1]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Bool() -> type = "bool.make_type";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Not(%b: bool) -> bool {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %b.ref: bool = name_ref b, %b
// CHECK:STDOUT:   %.loc8: bool = not %b.ref
// CHECK:STDOUT:   return %.loc8
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Constant() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc15_17: bool = bool_literal true [template = constants.%.2]
// CHECK:STDOUT:   %.loc15_13: bool = not %.loc15_17 [template = constants.%.3]
// CHECK:STDOUT:   if %.loc15_13 br !if.expr.then.loc15 else br !if.expr.else.loc15
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.then.loc15:
// CHECK:STDOUT:   %bool.make_type.loc15: init type = call constants.%struct.1() [template = bool]
// CHECK:STDOUT:   %.loc15_27.1: type = value_of_initializer %bool.make_type.loc15 [template = bool]
// CHECK:STDOUT:   %.loc15_27.2: type = converted %bool.make_type.loc15, %.loc15_27.1 [template = bool]
// CHECK:STDOUT:   br !if.expr.result.loc15(%.loc15_27.2)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.else.loc15:
// CHECK:STDOUT:   %.loc15_38: () = tuple_literal ()
// CHECK:STDOUT:   %.loc15_32: type = converted %.loc15_38, constants.%.1 [template = constants.%.1]
// CHECK:STDOUT:   br !if.expr.result.loc15(%.loc15_32)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.result.loc15:
// CHECK:STDOUT:   %.loc15_10: type = block_arg !if.expr.result.loc15 [template = constants.%.1]
// CHECK:STDOUT:   %a.var: ref () = var a
// CHECK:STDOUT:   %a: ref () = bind_name a, %a.var
// CHECK:STDOUT:   %.loc15_43.1: () = tuple_literal ()
// CHECK:STDOUT:   %.loc15_43.2: init () = tuple_init () to %a.var [template = constants.%tuple]
// CHECK:STDOUT:   %.loc15_44: init () = converted %.loc15_43.1, %.loc15_43.2 [template = constants.%tuple]
// CHECK:STDOUT:   assign %a.var, %.loc15_44
// CHECK:STDOUT:   %.loc16_17: bool = bool_literal false [template = constants.%.3]
// CHECK:STDOUT:   %.loc16_13: bool = not %.loc16_17 [template = constants.%.2]
// CHECK:STDOUT:   if %.loc16_13 br !if.expr.then.loc16 else br !if.expr.else.loc16
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.then.loc16:
// CHECK:STDOUT:   %bool.make_type.loc16: init type = call constants.%struct.1() [template = bool]
// CHECK:STDOUT:   %.loc16_28.1: type = value_of_initializer %bool.make_type.loc16 [template = bool]
// CHECK:STDOUT:   %.loc16_28.2: type = converted %bool.make_type.loc16, %.loc16_28.1 [template = bool]
// CHECK:STDOUT:   br !if.expr.result.loc16(%.loc16_28.2)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.else.loc16:
// CHECK:STDOUT:   %.loc16_39: () = tuple_literal ()
// CHECK:STDOUT:   %.loc16_33: type = converted %.loc16_39, constants.%.1 [template = constants.%.1]
// CHECK:STDOUT:   br !if.expr.result.loc16(%.loc16_33)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.result.loc16:
// CHECK:STDOUT:   %.loc16_10: type = block_arg !if.expr.result.loc16 [template = bool]
// CHECK:STDOUT:   %b.var: ref bool = var b
// CHECK:STDOUT:   %b: ref bool = bind_name b, %b.var
// CHECK:STDOUT:   %.loc16_43: bool = bool_literal true [template = constants.%.2]
// CHECK:STDOUT:   assign %b.var, %.loc16_43
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
