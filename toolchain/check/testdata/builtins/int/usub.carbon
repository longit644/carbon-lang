// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// --- int_sub.carbon

fn Sub(a: i32, b: i32) -> i32 = "int.usub";

var arr: [i32; Sub(3, 2)];
let arr_p: [i32; 1]* = &arr;

fn RuntimeCall(a: i32, b: i32) -> i32 {
  return Sub(a, b);
}

// --- overflow.carbon

package Overflow;

fn Sub(a: i32, b: i32) -> i32 = "int.usub";

let a: i32 = Sub(0, 0x7FFFFFFF);
let b: i32 = Sub(Sub(0, 0x7FFFFFFF), 1);
let c: i32 = Sub(Sub(0, 0x7FFFFFFF), 2);

// CHECK:STDOUT: --- int_sub.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Int32 = struct_value () [template]
// CHECK:STDOUT:   %Sub: type = fn_type @Sub [template]
// CHECK:STDOUT:   %struct.2: Sub = struct_value () [template]
// CHECK:STDOUT:   %.2: i32 = int_literal 3 [template]
// CHECK:STDOUT:   %.3: i32 = int_literal 2 [template]
// CHECK:STDOUT:   %.4: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %.5: type = array_type %.4, i32 [template]
// CHECK:STDOUT:   %.6: type = ptr_type [i32; 1] [template]
// CHECK:STDOUT:   %RuntimeCall: type = fn_type @RuntimeCall [template]
// CHECK:STDOUT:   %struct.3: RuntimeCall = struct_value () [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Sub = %Sub.decl
// CHECK:STDOUT:     .arr = %arr
// CHECK:STDOUT:     .RuntimeCall = %RuntimeCall.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.2: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.3: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %Sub.decl: Sub = fn_decl @Sub [template = constants.%struct.2] {
// CHECK:STDOUT:     %int.make_type_32.loc2_11: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc2_11.1: type = value_of_initializer %int.make_type_32.loc2_11 [template = i32]
// CHECK:STDOUT:     %.loc2_11.2: type = converted %int.make_type_32.loc2_11, %.loc2_11.1 [template = i32]
// CHECK:STDOUT:     %a.loc2_8.1: i32 = param a
// CHECK:STDOUT:     @Sub.%a: i32 = bind_name a, %a.loc2_8.1
// CHECK:STDOUT:     %int.make_type_32.loc2_19: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc2_19.1: type = value_of_initializer %int.make_type_32.loc2_19 [template = i32]
// CHECK:STDOUT:     %.loc2_19.2: type = converted %int.make_type_32.loc2_19, %.loc2_19.1 [template = i32]
// CHECK:STDOUT:     %b.loc2_16.1: i32 = param b
// CHECK:STDOUT:     @Sub.%b: i32 = bind_name b, %b.loc2_16.1
// CHECK:STDOUT:     %int.make_type_32.loc2_27: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc2_27.1: type = value_of_initializer %int.make_type_32.loc2_27 [template = i32]
// CHECK:STDOUT:     %.loc2_27.2: type = converted %int.make_type_32.loc2_27, %.loc2_27.1 [template = i32]
// CHECK:STDOUT:     @Sub.%return: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.4: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %int.make_type_32.loc4: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %Sub.ref: Sub = name_ref Sub, %Sub.decl [template = constants.%struct.2]
// CHECK:STDOUT:   %.loc4_20: i32 = int_literal 3 [template = constants.%.2]
// CHECK:STDOUT:   %.loc4_23: i32 = int_literal 2 [template = constants.%.3]
// CHECK:STDOUT:   %int.usub: init i32 = call %Sub.ref(%.loc4_20, %.loc4_23) [template = constants.%.4]
// CHECK:STDOUT:   %.loc4_11.1: type = value_of_initializer %int.make_type_32.loc4 [template = i32]
// CHECK:STDOUT:   %.loc4_11.2: type = converted %int.make_type_32.loc4, %.loc4_11.1 [template = i32]
// CHECK:STDOUT:   %.loc4_25: type = array_type %int.usub, i32 [template = constants.%.5]
// CHECK:STDOUT:   %arr.var: ref [i32; 1] = var arr
// CHECK:STDOUT:   %arr: ref [i32; 1] = bind_name arr, %arr.var
// CHECK:STDOUT:   %import_ref.5: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %int.make_type_32.loc5: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %.loc5_18: i32 = int_literal 1 [template = constants.%.4]
// CHECK:STDOUT:   %.loc5_13.1: type = value_of_initializer %int.make_type_32.loc5 [template = i32]
// CHECK:STDOUT:   %.loc5_13.2: type = converted %int.make_type_32.loc5, %.loc5_13.1 [template = i32]
// CHECK:STDOUT:   %.loc5_19: type = array_type %.loc5_18, i32 [template = constants.%.5]
// CHECK:STDOUT:   %.loc5_20: type = ptr_type [i32; 1] [template = constants.%.6]
// CHECK:STDOUT:   %arr.ref: ref [i32; 1] = name_ref arr, %arr
// CHECK:STDOUT:   %.loc5_24: [i32; 1]* = addr_of %arr.ref
// CHECK:STDOUT:   %arr_p: [i32; 1]* = bind_name arr_p, %.loc5_24
// CHECK:STDOUT:   %import_ref.6: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.7: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.8: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %RuntimeCall.decl: RuntimeCall = fn_decl @RuntimeCall [template = constants.%struct.3] {
// CHECK:STDOUT:     %int.make_type_32.loc7_19: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc7_19.1: type = value_of_initializer %int.make_type_32.loc7_19 [template = i32]
// CHECK:STDOUT:     %.loc7_19.2: type = converted %int.make_type_32.loc7_19, %.loc7_19.1 [template = i32]
// CHECK:STDOUT:     %a.loc7_16.1: i32 = param a
// CHECK:STDOUT:     @RuntimeCall.%a: i32 = bind_name a, %a.loc7_16.1
// CHECK:STDOUT:     %int.make_type_32.loc7_27: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc7_27.1: type = value_of_initializer %int.make_type_32.loc7_27 [template = i32]
// CHECK:STDOUT:     %.loc7_27.2: type = converted %int.make_type_32.loc7_27, %.loc7_27.1 [template = i32]
// CHECK:STDOUT:     %b.loc7_24.1: i32 = param b
// CHECK:STDOUT:     @RuntimeCall.%b: i32 = bind_name b, %b.loc7_24.1
// CHECK:STDOUT:     %int.make_type_32.loc7_35: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc7_35.1: type = value_of_initializer %int.make_type_32.loc7_35 [template = i32]
// CHECK:STDOUT:     %.loc7_35.2: type = converted %int.make_type_32.loc7_35, %.loc7_35.1 [template = i32]
// CHECK:STDOUT:     @RuntimeCall.%return: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Sub(%a: i32, %b: i32) -> i32 = "int.usub";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @RuntimeCall(%a: i32, %b: i32) -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %Sub.ref: Sub = name_ref Sub, file.%Sub.decl [template = constants.%struct.2]
// CHECK:STDOUT:   %a.ref: i32 = name_ref a, %a
// CHECK:STDOUT:   %b.ref: i32 = name_ref b, %b
// CHECK:STDOUT:   %int.usub: init i32 = call %Sub.ref(%a.ref, %b.ref)
// CHECK:STDOUT:   %.loc8_19.1: i32 = value_of_initializer %int.usub
// CHECK:STDOUT:   %.loc8_19.2: i32 = converted %int.usub, %.loc8_19.1
// CHECK:STDOUT:   return %.loc8_19.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- overflow.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Int32 = struct_value () [template]
// CHECK:STDOUT:   %Sub: type = fn_type @Sub [template]
// CHECK:STDOUT:   %struct.2: Sub = struct_value () [template]
// CHECK:STDOUT:   %.2: i32 = int_literal 0 [template]
// CHECK:STDOUT:   %.3: i32 = int_literal 2147483647 [template]
// CHECK:STDOUT:   %.4: i32 = int_literal -2147483647 [template]
// CHECK:STDOUT:   %.5: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %.6: i32 = int_literal -2147483648 [template]
// CHECK:STDOUT:   %.7: i32 = int_literal 2 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Sub = %Sub.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.2: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.3: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %Sub.decl: Sub = fn_decl @Sub [template = constants.%struct.2] {
// CHECK:STDOUT:     %int.make_type_32.loc4_11: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc4_11.1: type = value_of_initializer %int.make_type_32.loc4_11 [template = i32]
// CHECK:STDOUT:     %.loc4_11.2: type = converted %int.make_type_32.loc4_11, %.loc4_11.1 [template = i32]
// CHECK:STDOUT:     %a.loc4_8.1: i32 = param a
// CHECK:STDOUT:     @Sub.%a: i32 = bind_name a, %a.loc4_8.1
// CHECK:STDOUT:     %int.make_type_32.loc4_19: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc4_19.1: type = value_of_initializer %int.make_type_32.loc4_19 [template = i32]
// CHECK:STDOUT:     %.loc4_19.2: type = converted %int.make_type_32.loc4_19, %.loc4_19.1 [template = i32]
// CHECK:STDOUT:     %b.loc4_16.1: i32 = param b
// CHECK:STDOUT:     @Sub.%b: i32 = bind_name b, %b.loc4_16.1
// CHECK:STDOUT:     %int.make_type_32.loc4_27: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc4_27.1: type = value_of_initializer %int.make_type_32.loc4_27 [template = i32]
// CHECK:STDOUT:     %.loc4_27.2: type = converted %int.make_type_32.loc4_27, %.loc4_27.1 [template = i32]
// CHECK:STDOUT:     @Sub.%return: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.4: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %int.make_type_32.loc6: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %.loc6_8.1: type = value_of_initializer %int.make_type_32.loc6 [template = i32]
// CHECK:STDOUT:   %.loc6_8.2: type = converted %int.make_type_32.loc6, %.loc6_8.1 [template = i32]
// CHECK:STDOUT:   %Sub.ref.loc6: Sub = name_ref Sub, %Sub.decl [template = constants.%struct.2]
// CHECK:STDOUT:   %.loc6_18: i32 = int_literal 0 [template = constants.%.2]
// CHECK:STDOUT:   %.loc6_21: i32 = int_literal 2147483647 [template = constants.%.3]
// CHECK:STDOUT:   %int.usub.loc6: init i32 = call %Sub.ref.loc6(%.loc6_18, %.loc6_21) [template = constants.%.4]
// CHECK:STDOUT:   %.loc6_32.1: i32 = value_of_initializer %int.usub.loc6 [template = constants.%.4]
// CHECK:STDOUT:   %.loc6_32.2: i32 = converted %int.usub.loc6, %.loc6_32.1 [template = constants.%.4]
// CHECK:STDOUT:   %a.loc6: i32 = bind_name a, %.loc6_32.2
// CHECK:STDOUT:   %import_ref.5: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %int.make_type_32.loc7: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %.loc7_8.1: type = value_of_initializer %int.make_type_32.loc7 [template = i32]
// CHECK:STDOUT:   %.loc7_8.2: type = converted %int.make_type_32.loc7, %.loc7_8.1 [template = i32]
// CHECK:STDOUT:   %Sub.ref.loc7_14: Sub = name_ref Sub, %Sub.decl [template = constants.%struct.2]
// CHECK:STDOUT:   %Sub.ref.loc7_18: Sub = name_ref Sub, %Sub.decl [template = constants.%struct.2]
// CHECK:STDOUT:   %.loc7_22: i32 = int_literal 0 [template = constants.%.2]
// CHECK:STDOUT:   %.loc7_25: i32 = int_literal 2147483647 [template = constants.%.3]
// CHECK:STDOUT:   %int.usub.loc7_21: init i32 = call %Sub.ref.loc7_18(%.loc7_22, %.loc7_25) [template = constants.%.4]
// CHECK:STDOUT:   %.loc7_38: i32 = int_literal 1 [template = constants.%.5]
// CHECK:STDOUT:   %.loc7_17.1: i32 = value_of_initializer %int.usub.loc7_21 [template = constants.%.4]
// CHECK:STDOUT:   %.loc7_17.2: i32 = converted %int.usub.loc7_21, %.loc7_17.1 [template = constants.%.4]
// CHECK:STDOUT:   %int.usub.loc7_17: init i32 = call %Sub.ref.loc7_14(%.loc7_17.2, %.loc7_38) [template = constants.%.6]
// CHECK:STDOUT:   %.loc7_40.1: i32 = value_of_initializer %int.usub.loc7_17 [template = constants.%.6]
// CHECK:STDOUT:   %.loc7_40.2: i32 = converted %int.usub.loc7_17, %.loc7_40.1 [template = constants.%.6]
// CHECK:STDOUT:   %b.loc7: i32 = bind_name b, %.loc7_40.2
// CHECK:STDOUT:   %import_ref.6: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %int.make_type_32.loc8: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %.loc8_8.1: type = value_of_initializer %int.make_type_32.loc8 [template = i32]
// CHECK:STDOUT:   %.loc8_8.2: type = converted %int.make_type_32.loc8, %.loc8_8.1 [template = i32]
// CHECK:STDOUT:   %Sub.ref.loc8_14: Sub = name_ref Sub, %Sub.decl [template = constants.%struct.2]
// CHECK:STDOUT:   %Sub.ref.loc8_18: Sub = name_ref Sub, %Sub.decl [template = constants.%struct.2]
// CHECK:STDOUT:   %.loc8_22: i32 = int_literal 0 [template = constants.%.2]
// CHECK:STDOUT:   %.loc8_25: i32 = int_literal 2147483647 [template = constants.%.3]
// CHECK:STDOUT:   %int.usub.loc8_21: init i32 = call %Sub.ref.loc8_18(%.loc8_22, %.loc8_25) [template = constants.%.4]
// CHECK:STDOUT:   %.loc8_38: i32 = int_literal 2 [template = constants.%.7]
// CHECK:STDOUT:   %.loc8_17.1: i32 = value_of_initializer %int.usub.loc8_21 [template = constants.%.4]
// CHECK:STDOUT:   %.loc8_17.2: i32 = converted %int.usub.loc8_21, %.loc8_17.1 [template = constants.%.4]
// CHECK:STDOUT:   %int.usub.loc8_17: init i32 = call %Sub.ref.loc8_14(%.loc8_17.2, %.loc8_38) [template = constants.%.3]
// CHECK:STDOUT:   %.loc8_40.1: i32 = value_of_initializer %int.usub.loc8_17 [template = constants.%.3]
// CHECK:STDOUT:   %.loc8_40.2: i32 = converted %int.usub.loc8_17, %.loc8_40.1 [template = constants.%.3]
// CHECK:STDOUT:   %c: i32 = bind_name c, %.loc8_40.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Sub(%a: i32, %b: i32) -> i32 = "int.usub";
// CHECK:STDOUT:
