// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// --- int_add.carbon

fn Add(a: i32, b: i32) -> i32 = "int.uadd";

var arr: [i32; Add(1, 2)];
let arr_p: [i32; 3]* = &arr;

fn RuntimeCall(a: i32, b: i32) -> i32 {
  return Add(a, b);
}

// --- fail_bad_decl.carbon

package FailBadDecl;

// CHECK:STDERR: fail_bad_decl.carbon:[[@LINE+4]]:1: ERROR: Invalid signature for builtin function "int.uadd".
// CHECK:STDERR: fn TooFew(a: i32) -> i32 = "int.uadd";
// CHECK:STDERR: ^~~~~~~~~~~~~~~~~~~~~~~~~~
// CHECK:STDERR:
fn TooFew(a: i32) -> i32 = "int.uadd";
// CHECK:STDERR: fail_bad_decl.carbon:[[@LINE+4]]:1: ERROR: Invalid signature for builtin function "int.uadd".
// CHECK:STDERR: fn TooMany(a: i32, b: i32, c: i32) -> i32 = "int.uadd";
// CHECK:STDERR: ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// CHECK:STDERR:
fn TooMany(a: i32, b: i32, c: i32) -> i32 = "int.uadd";
// CHECK:STDERR: fail_bad_decl.carbon:[[@LINE+4]]:1: ERROR: Invalid signature for builtin function "int.uadd".
// CHECK:STDERR: fn BadReturnType(a: i32, b: i32) -> bool = "int.uadd";
// CHECK:STDERR: ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// CHECK:STDERR:
fn BadReturnType(a: i32, b: i32) -> bool = "int.uadd";
fn JustRight(a: i32, b: i32) -> i32 = "int.uadd";

// CHECK:STDERR: fail_bad_decl.carbon:[[@LINE+4]]:20: ERROR: Array bound is not a constant.
// CHECK:STDERR: var too_few: [i32; TooFew(1)];
// CHECK:STDERR:                    ^~~~~~~
// CHECK:STDERR:
var too_few: [i32; TooFew(1)];
// CHECK:STDERR: fail_bad_decl.carbon:[[@LINE+4]]:21: ERROR: Array bound is not a constant.
// CHECK:STDERR: var too_many: [i32; TooMany(1, 2, 3)];
// CHECK:STDERR:                     ^~~~~~~~
// CHECK:STDERR:
var too_many: [i32; TooMany(1, 2, 3)];
// CHECK:STDERR: fail_bad_decl.carbon:[[@LINE+4]]:28: ERROR: Array bound is not a constant.
// CHECK:STDERR: var bad_return_type: [i32; BadReturnType(1, 2)];
// CHECK:STDERR:                            ^~~~~~~~~~~~~~
// CHECK:STDERR:
var bad_return_type: [i32; BadReturnType(1, 2)];

// CHECK:STDERR: fail_bad_decl.carbon:[[@LINE+6]]:21: ERROR: 3 argument(s) passed to function expecting 2 argument(s).
// CHECK:STDERR: var bad_call: [i32; JustRight(1, 2, 3)];
// CHECK:STDERR:                     ^~~~~~~~~~
// CHECK:STDERR: fail_bad_decl.carbon:[[@LINE-21]]:1: Calling function declared here.
// CHECK:STDERR: fn JustRight(a: i32, b: i32) -> i32 = "int.uadd";
// CHECK:STDERR: ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var bad_call: [i32; JustRight(1, 2, 3)];

fn RuntimeCallTooFew(a: i32) -> i32 {
  return TooFew(a);
}

fn RuntimeCallTooMany(a: i32, b: i32, c: i32) -> i32 {
  return TooMany(a, b, c);
}

fn RuntimeCallBadReturnType(a: i32, b: i32) -> bool {
  return BadReturnType(a, b);
}

// --- overflow.carbon

package Overflow;

fn Add(a: i32, b: i32) -> i32 = "int.uadd";

// Overflow is OK.
let a: i32 = Add(0x7FFFFFFF, 0);
let b: i32 = Add(0x7FFFFFFF, 1);

// CHECK:STDOUT: --- int_add.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Int32 = struct_value () [template]
// CHECK:STDOUT:   %Add: type = fn_type @Add [template]
// CHECK:STDOUT:   %struct.2: Add = struct_value () [template]
// CHECK:STDOUT:   %.2: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %.3: i32 = int_literal 2 [template]
// CHECK:STDOUT:   %.4: i32 = int_literal 3 [template]
// CHECK:STDOUT:   %.5: type = array_type %.4, i32 [template]
// CHECK:STDOUT:   %.6: type = ptr_type [i32; 3] [template]
// CHECK:STDOUT:   %RuntimeCall: type = fn_type @RuntimeCall [template]
// CHECK:STDOUT:   %struct.3: RuntimeCall = struct_value () [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Add = %Add.decl
// CHECK:STDOUT:     .arr = %arr
// CHECK:STDOUT:     .RuntimeCall = %RuntimeCall.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.2: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.3: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %Add.decl: Add = fn_decl @Add [template = constants.%struct.2] {
// CHECK:STDOUT:     %int.make_type_32.loc2_11: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc2_11.1: type = value_of_initializer %int.make_type_32.loc2_11 [template = i32]
// CHECK:STDOUT:     %.loc2_11.2: type = converted %int.make_type_32.loc2_11, %.loc2_11.1 [template = i32]
// CHECK:STDOUT:     %a.loc2_8.1: i32 = param a
// CHECK:STDOUT:     @Add.%a: i32 = bind_name a, %a.loc2_8.1
// CHECK:STDOUT:     %int.make_type_32.loc2_19: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc2_19.1: type = value_of_initializer %int.make_type_32.loc2_19 [template = i32]
// CHECK:STDOUT:     %.loc2_19.2: type = converted %int.make_type_32.loc2_19, %.loc2_19.1 [template = i32]
// CHECK:STDOUT:     %b.loc2_16.1: i32 = param b
// CHECK:STDOUT:     @Add.%b: i32 = bind_name b, %b.loc2_16.1
// CHECK:STDOUT:     %int.make_type_32.loc2_27: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc2_27.1: type = value_of_initializer %int.make_type_32.loc2_27 [template = i32]
// CHECK:STDOUT:     %.loc2_27.2: type = converted %int.make_type_32.loc2_27, %.loc2_27.1 [template = i32]
// CHECK:STDOUT:     @Add.%return: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.4: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %int.make_type_32.loc4: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %Add.ref: Add = name_ref Add, %Add.decl [template = constants.%struct.2]
// CHECK:STDOUT:   %.loc4_20: i32 = int_literal 1 [template = constants.%.2]
// CHECK:STDOUT:   %.loc4_23: i32 = int_literal 2 [template = constants.%.3]
// CHECK:STDOUT:   %int.uadd: init i32 = call %Add.ref(%.loc4_20, %.loc4_23) [template = constants.%.4]
// CHECK:STDOUT:   %.loc4_11.1: type = value_of_initializer %int.make_type_32.loc4 [template = i32]
// CHECK:STDOUT:   %.loc4_11.2: type = converted %int.make_type_32.loc4, %.loc4_11.1 [template = i32]
// CHECK:STDOUT:   %.loc4_25: type = array_type %int.uadd, i32 [template = constants.%.5]
// CHECK:STDOUT:   %arr.var: ref [i32; 3] = var arr
// CHECK:STDOUT:   %arr: ref [i32; 3] = bind_name arr, %arr.var
// CHECK:STDOUT:   %import_ref.5: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %int.make_type_32.loc5: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %.loc5_18: i32 = int_literal 3 [template = constants.%.4]
// CHECK:STDOUT:   %.loc5_13.1: type = value_of_initializer %int.make_type_32.loc5 [template = i32]
// CHECK:STDOUT:   %.loc5_13.2: type = converted %int.make_type_32.loc5, %.loc5_13.1 [template = i32]
// CHECK:STDOUT:   %.loc5_19: type = array_type %.loc5_18, i32 [template = constants.%.5]
// CHECK:STDOUT:   %.loc5_20: type = ptr_type [i32; 3] [template = constants.%.6]
// CHECK:STDOUT:   %arr.ref: ref [i32; 3] = name_ref arr, %arr
// CHECK:STDOUT:   %.loc5_24: [i32; 3]* = addr_of %arr.ref
// CHECK:STDOUT:   %arr_p: [i32; 3]* = bind_name arr_p, %.loc5_24
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
// CHECK:STDOUT: fn @Add(%a: i32, %b: i32) -> i32 = "int.uadd";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @RuntimeCall(%a: i32, %b: i32) -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %Add.ref: Add = name_ref Add, file.%Add.decl [template = constants.%struct.2]
// CHECK:STDOUT:   %a.ref: i32 = name_ref a, %a
// CHECK:STDOUT:   %b.ref: i32 = name_ref b, %b
// CHECK:STDOUT:   %int.uadd: init i32 = call %Add.ref(%a.ref, %b.ref)
// CHECK:STDOUT:   %.loc8_19.1: i32 = value_of_initializer %int.uadd
// CHECK:STDOUT:   %.loc8_19.2: i32 = converted %int.uadd, %.loc8_19.1
// CHECK:STDOUT:   return %.loc8_19.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- fail_bad_decl.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Int32 = struct_value () [template]
// CHECK:STDOUT:   %TooFew: type = fn_type @TooFew [template]
// CHECK:STDOUT:   %struct.2: TooFew = struct_value () [template]
// CHECK:STDOUT:   %TooMany: type = fn_type @TooMany [template]
// CHECK:STDOUT:   %struct.3: TooMany = struct_value () [template]
// CHECK:STDOUT:   %Bool: type = fn_type @Bool [template]
// CHECK:STDOUT:   %struct.4: Bool = struct_value () [template]
// CHECK:STDOUT:   %BadReturnType: type = fn_type @BadReturnType [template]
// CHECK:STDOUT:   %struct.5: BadReturnType = struct_value () [template]
// CHECK:STDOUT:   %JustRight: type = fn_type @JustRight [template]
// CHECK:STDOUT:   %struct.6: JustRight = struct_value () [template]
// CHECK:STDOUT:   %.2: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %.3: i32 = int_literal 2 [template]
// CHECK:STDOUT:   %.4: i32 = int_literal 3 [template]
// CHECK:STDOUT:   %RuntimeCallTooFew: type = fn_type @RuntimeCallTooFew [template]
// CHECK:STDOUT:   %struct.7: RuntimeCallTooFew = struct_value () [template]
// CHECK:STDOUT:   %RuntimeCallTooMany: type = fn_type @RuntimeCallTooMany [template]
// CHECK:STDOUT:   %struct.8: RuntimeCallTooMany = struct_value () [template]
// CHECK:STDOUT:   %RuntimeCallBadReturnType: type = fn_type @RuntimeCallBadReturnType [template]
// CHECK:STDOUT:   %struct.9: RuntimeCallBadReturnType = struct_value () [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .TooFew = %TooFew.decl
// CHECK:STDOUT:     .TooMany = %TooMany.decl
// CHECK:STDOUT:     .BadReturnType = %BadReturnType.decl
// CHECK:STDOUT:     .JustRight = %JustRight.decl
// CHECK:STDOUT:     .too_few = %too_few
// CHECK:STDOUT:     .too_many = %too_many
// CHECK:STDOUT:     .bad_return_type = %bad_return_type
// CHECK:STDOUT:     .bad_call = %bad_call
// CHECK:STDOUT:     .RuntimeCallTooFew = %RuntimeCallTooFew.decl
// CHECK:STDOUT:     .RuntimeCallTooMany = %RuntimeCallTooMany.decl
// CHECK:STDOUT:     .RuntimeCallBadReturnType = %RuntimeCallBadReturnType.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.2: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %TooFew.decl: TooFew = fn_decl @TooFew [template = constants.%struct.2] {
// CHECK:STDOUT:     %int.make_type_32.loc8_14: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc8_14.1: type = value_of_initializer %int.make_type_32.loc8_14 [template = i32]
// CHECK:STDOUT:     %.loc8_14.2: type = converted %int.make_type_32.loc8_14, %.loc8_14.1 [template = i32]
// CHECK:STDOUT:     %a.loc8_11.1: i32 = param a
// CHECK:STDOUT:     @TooFew.%a: i32 = bind_name a, %a.loc8_11.1
// CHECK:STDOUT:     %int.make_type_32.loc8_22: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc8_22.1: type = value_of_initializer %int.make_type_32.loc8_22 [template = i32]
// CHECK:STDOUT:     %.loc8_22.2: type = converted %int.make_type_32.loc8_22, %.loc8_22.1 [template = i32]
// CHECK:STDOUT:     @TooFew.%return: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.3: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.4: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.5: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.6: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %TooMany.decl: TooMany = fn_decl @TooMany [template = constants.%struct.3] {
// CHECK:STDOUT:     %int.make_type_32.loc13_15: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc13_15.1: type = value_of_initializer %int.make_type_32.loc13_15 [template = i32]
// CHECK:STDOUT:     %.loc13_15.2: type = converted %int.make_type_32.loc13_15, %.loc13_15.1 [template = i32]
// CHECK:STDOUT:     %a.loc13_12.1: i32 = param a
// CHECK:STDOUT:     @TooMany.%a: i32 = bind_name a, %a.loc13_12.1
// CHECK:STDOUT:     %int.make_type_32.loc13_23: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc13_23.1: type = value_of_initializer %int.make_type_32.loc13_23 [template = i32]
// CHECK:STDOUT:     %.loc13_23.2: type = converted %int.make_type_32.loc13_23, %.loc13_23.1 [template = i32]
// CHECK:STDOUT:     %b.loc13_20.1: i32 = param b
// CHECK:STDOUT:     @TooMany.%b: i32 = bind_name b, %b.loc13_20.1
// CHECK:STDOUT:     %int.make_type_32.loc13_31: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc13_31.1: type = value_of_initializer %int.make_type_32.loc13_31 [template = i32]
// CHECK:STDOUT:     %.loc13_31.2: type = converted %int.make_type_32.loc13_31, %.loc13_31.1 [template = i32]
// CHECK:STDOUT:     %c.loc13_28.1: i32 = param c
// CHECK:STDOUT:     @TooMany.%c: i32 = bind_name c, %c.loc13_28.1
// CHECK:STDOUT:     %int.make_type_32.loc13_39: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc13_39.1: type = value_of_initializer %int.make_type_32.loc13_39 [template = i32]
// CHECK:STDOUT:     %.loc13_39.2: type = converted %int.make_type_32.loc13_39, %.loc13_39.1 [template = i32]
// CHECK:STDOUT:     @TooMany.%return: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.7: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.8: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.9: Bool = import_ref ir7, inst+2, loaded [template = constants.%struct.4]
// CHECK:STDOUT:   %BadReturnType.decl: BadReturnType = fn_decl @BadReturnType [template = constants.%struct.5] {
// CHECK:STDOUT:     %int.make_type_32.loc18_21: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc18_21.1: type = value_of_initializer %int.make_type_32.loc18_21 [template = i32]
// CHECK:STDOUT:     %.loc18_21.2: type = converted %int.make_type_32.loc18_21, %.loc18_21.1 [template = i32]
// CHECK:STDOUT:     %a.loc18_18.1: i32 = param a
// CHECK:STDOUT:     @BadReturnType.%a: i32 = bind_name a, %a.loc18_18.1
// CHECK:STDOUT:     %int.make_type_32.loc18_29: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc18_29.1: type = value_of_initializer %int.make_type_32.loc18_29 [template = i32]
// CHECK:STDOUT:     %.loc18_29.2: type = converted %int.make_type_32.loc18_29, %.loc18_29.1 [template = i32]
// CHECK:STDOUT:     %b.loc18_26.1: i32 = param b
// CHECK:STDOUT:     @BadReturnType.%b: i32 = bind_name b, %b.loc18_26.1
// CHECK:STDOUT:     %bool.make_type.loc18: init type = call constants.%struct.4() [template = bool]
// CHECK:STDOUT:     %.loc18_37.1: type = value_of_initializer %bool.make_type.loc18 [template = bool]
// CHECK:STDOUT:     %.loc18_37.2: type = converted %bool.make_type.loc18, %.loc18_37.1 [template = bool]
// CHECK:STDOUT:     @BadReturnType.%return: ref bool = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.10: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.11: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.12: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %JustRight.decl: JustRight = fn_decl @JustRight [template = constants.%struct.6] {
// CHECK:STDOUT:     %int.make_type_32.loc19_17: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc19_17.1: type = value_of_initializer %int.make_type_32.loc19_17 [template = i32]
// CHECK:STDOUT:     %.loc19_17.2: type = converted %int.make_type_32.loc19_17, %.loc19_17.1 [template = i32]
// CHECK:STDOUT:     %a.loc19_14.1: i32 = param a
// CHECK:STDOUT:     @JustRight.%a: i32 = bind_name a, %a.loc19_14.1
// CHECK:STDOUT:     %int.make_type_32.loc19_25: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc19_25.1: type = value_of_initializer %int.make_type_32.loc19_25 [template = i32]
// CHECK:STDOUT:     %.loc19_25.2: type = converted %int.make_type_32.loc19_25, %.loc19_25.1 [template = i32]
// CHECK:STDOUT:     %b.loc19_22.1: i32 = param b
// CHECK:STDOUT:     @JustRight.%b: i32 = bind_name b, %b.loc19_22.1
// CHECK:STDOUT:     %int.make_type_32.loc19_33: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc19_33.1: type = value_of_initializer %int.make_type_32.loc19_33 [template = i32]
// CHECK:STDOUT:     %.loc19_33.2: type = converted %int.make_type_32.loc19_33, %.loc19_33.1 [template = i32]
// CHECK:STDOUT:     @JustRight.%return: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.13: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %int.make_type_32.loc25: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %TooFew.ref: TooFew = name_ref TooFew, %TooFew.decl [template = constants.%struct.2]
// CHECK:STDOUT:   %.loc25: i32 = int_literal 1 [template = constants.%.2]
// CHECK:STDOUT:   %TooFew.call: init i32 = call %TooFew.ref(%.loc25)
// CHECK:STDOUT:   %too_few.var: ref <error> = var too_few
// CHECK:STDOUT:   %too_few: ref <error> = bind_name too_few, %too_few.var
// CHECK:STDOUT:   %import_ref.14: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %int.make_type_32.loc30: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %TooMany.ref: TooMany = name_ref TooMany, %TooMany.decl [template = constants.%struct.3]
// CHECK:STDOUT:   %.loc30_29: i32 = int_literal 1 [template = constants.%.2]
// CHECK:STDOUT:   %.loc30_32: i32 = int_literal 2 [template = constants.%.3]
// CHECK:STDOUT:   %.loc30_35: i32 = int_literal 3 [template = constants.%.4]
// CHECK:STDOUT:   %TooMany.call: init i32 = call %TooMany.ref(%.loc30_29, %.loc30_32, %.loc30_35)
// CHECK:STDOUT:   %too_many.var: ref <error> = var too_many
// CHECK:STDOUT:   %too_many: ref <error> = bind_name too_many, %too_many.var
// CHECK:STDOUT:   %import_ref.15: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %int.make_type_32.loc35: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %BadReturnType.ref: BadReturnType = name_ref BadReturnType, %BadReturnType.decl [template = constants.%struct.5]
// CHECK:STDOUT:   %.loc35_42: i32 = int_literal 1 [template = constants.%.2]
// CHECK:STDOUT:   %.loc35_45: i32 = int_literal 2 [template = constants.%.3]
// CHECK:STDOUT:   %BadReturnType.call: init bool = call %BadReturnType.ref(%.loc35_42, %.loc35_45)
// CHECK:STDOUT:   %bad_return_type.var: ref <error> = var bad_return_type
// CHECK:STDOUT:   %bad_return_type: ref <error> = bind_name bad_return_type, %bad_return_type.var
// CHECK:STDOUT:   %import_ref.16: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %int.make_type_32.loc43: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %JustRight.ref: JustRight = name_ref JustRight, %JustRight.decl [template = constants.%struct.6]
// CHECK:STDOUT:   %.loc43_31: i32 = int_literal 1 [template = constants.%.2]
// CHECK:STDOUT:   %.loc43_34: i32 = int_literal 2 [template = constants.%.3]
// CHECK:STDOUT:   %.loc43_37: i32 = int_literal 3 [template = constants.%.4]
// CHECK:STDOUT:   %int.uadd: init i32 = call %JustRight.ref(<invalid>) [template = <error>]
// CHECK:STDOUT:   %.loc43_16.1: type = value_of_initializer %int.make_type_32.loc43 [template = i32]
// CHECK:STDOUT:   %.loc43_16.2: type = converted %int.make_type_32.loc43, %.loc43_16.1 [template = i32]
// CHECK:STDOUT:   %.loc43_39: type = array_type %int.uadd, i32 [template = <error>]
// CHECK:STDOUT:   %bad_call.var: ref <error> = var bad_call
// CHECK:STDOUT:   %bad_call: ref <error> = bind_name bad_call, %bad_call.var
// CHECK:STDOUT:   %import_ref.17: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.18: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %RuntimeCallTooFew.decl: RuntimeCallTooFew = fn_decl @RuntimeCallTooFew [template = constants.%struct.7] {
// CHECK:STDOUT:     %int.make_type_32.loc45_25: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc45_25.1: type = value_of_initializer %int.make_type_32.loc45_25 [template = i32]
// CHECK:STDOUT:     %.loc45_25.2: type = converted %int.make_type_32.loc45_25, %.loc45_25.1 [template = i32]
// CHECK:STDOUT:     %a.loc45_22.1: i32 = param a
// CHECK:STDOUT:     @RuntimeCallTooFew.%a: i32 = bind_name a, %a.loc45_22.1
// CHECK:STDOUT:     %int.make_type_32.loc45_33: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc45_33.1: type = value_of_initializer %int.make_type_32.loc45_33 [template = i32]
// CHECK:STDOUT:     %.loc45_33.2: type = converted %int.make_type_32.loc45_33, %.loc45_33.1 [template = i32]
// CHECK:STDOUT:     @RuntimeCallTooFew.%return: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.19: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.20: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.21: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.22: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %RuntimeCallTooMany.decl: RuntimeCallTooMany = fn_decl @RuntimeCallTooMany [template = constants.%struct.8] {
// CHECK:STDOUT:     %int.make_type_32.loc49_26: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc49_26.1: type = value_of_initializer %int.make_type_32.loc49_26 [template = i32]
// CHECK:STDOUT:     %.loc49_26.2: type = converted %int.make_type_32.loc49_26, %.loc49_26.1 [template = i32]
// CHECK:STDOUT:     %a.loc49_23.1: i32 = param a
// CHECK:STDOUT:     @RuntimeCallTooMany.%a: i32 = bind_name a, %a.loc49_23.1
// CHECK:STDOUT:     %int.make_type_32.loc49_34: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc49_34.1: type = value_of_initializer %int.make_type_32.loc49_34 [template = i32]
// CHECK:STDOUT:     %.loc49_34.2: type = converted %int.make_type_32.loc49_34, %.loc49_34.1 [template = i32]
// CHECK:STDOUT:     %b.loc49_31.1: i32 = param b
// CHECK:STDOUT:     @RuntimeCallTooMany.%b: i32 = bind_name b, %b.loc49_31.1
// CHECK:STDOUT:     %int.make_type_32.loc49_42: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc49_42.1: type = value_of_initializer %int.make_type_32.loc49_42 [template = i32]
// CHECK:STDOUT:     %.loc49_42.2: type = converted %int.make_type_32.loc49_42, %.loc49_42.1 [template = i32]
// CHECK:STDOUT:     %c.loc49_39.1: i32 = param c
// CHECK:STDOUT:     @RuntimeCallTooMany.%c: i32 = bind_name c, %c.loc49_39.1
// CHECK:STDOUT:     %int.make_type_32.loc49_50: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc49_50.1: type = value_of_initializer %int.make_type_32.loc49_50 [template = i32]
// CHECK:STDOUT:     %.loc49_50.2: type = converted %int.make_type_32.loc49_50, %.loc49_50.1 [template = i32]
// CHECK:STDOUT:     @RuntimeCallTooMany.%return: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.23: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.24: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.25: Bool = import_ref ir7, inst+2, loaded [template = constants.%struct.4]
// CHECK:STDOUT:   %RuntimeCallBadReturnType.decl: RuntimeCallBadReturnType = fn_decl @RuntimeCallBadReturnType [template = constants.%struct.9] {
// CHECK:STDOUT:     %int.make_type_32.loc53_32: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc53_32.1: type = value_of_initializer %int.make_type_32.loc53_32 [template = i32]
// CHECK:STDOUT:     %.loc53_32.2: type = converted %int.make_type_32.loc53_32, %.loc53_32.1 [template = i32]
// CHECK:STDOUT:     %a.loc53_29.1: i32 = param a
// CHECK:STDOUT:     @RuntimeCallBadReturnType.%a: i32 = bind_name a, %a.loc53_29.1
// CHECK:STDOUT:     %int.make_type_32.loc53_40: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc53_40.1: type = value_of_initializer %int.make_type_32.loc53_40 [template = i32]
// CHECK:STDOUT:     %.loc53_40.2: type = converted %int.make_type_32.loc53_40, %.loc53_40.1 [template = i32]
// CHECK:STDOUT:     %b.loc53_37.1: i32 = param b
// CHECK:STDOUT:     @RuntimeCallBadReturnType.%b: i32 = bind_name b, %b.loc53_37.1
// CHECK:STDOUT:     %bool.make_type.loc53: init type = call constants.%struct.4() [template = bool]
// CHECK:STDOUT:     %.loc53_48.1: type = value_of_initializer %bool.make_type.loc53 [template = bool]
// CHECK:STDOUT:     %.loc53_48.2: type = converted %bool.make_type.loc53, %.loc53_48.1 [template = bool]
// CHECK:STDOUT:     @RuntimeCallBadReturnType.%return: ref bool = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @TooFew(%a: i32) -> i32;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @TooMany(%a: i32, %b: i32, %c: i32) -> i32;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Bool() -> type = "bool.make_type";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @BadReturnType(%a: i32, %b: i32) -> bool;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @JustRight(%a: i32, %b: i32) -> i32 = "int.uadd";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @RuntimeCallTooFew(%a: i32) -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %TooFew.ref: TooFew = name_ref TooFew, file.%TooFew.decl [template = constants.%struct.2]
// CHECK:STDOUT:   %a.ref: i32 = name_ref a, %a
// CHECK:STDOUT:   %TooFew.call: init i32 = call %TooFew.ref(%a.ref)
// CHECK:STDOUT:   %.loc46_19.1: i32 = value_of_initializer %TooFew.call
// CHECK:STDOUT:   %.loc46_19.2: i32 = converted %TooFew.call, %.loc46_19.1
// CHECK:STDOUT:   return %.loc46_19.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @RuntimeCallTooMany(%a: i32, %b: i32, %c: i32) -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %TooMany.ref: TooMany = name_ref TooMany, file.%TooMany.decl [template = constants.%struct.3]
// CHECK:STDOUT:   %a.ref: i32 = name_ref a, %a
// CHECK:STDOUT:   %b.ref: i32 = name_ref b, %b
// CHECK:STDOUT:   %c.ref: i32 = name_ref c, %c
// CHECK:STDOUT:   %TooMany.call: init i32 = call %TooMany.ref(%a.ref, %b.ref, %c.ref)
// CHECK:STDOUT:   %.loc50_26.1: i32 = value_of_initializer %TooMany.call
// CHECK:STDOUT:   %.loc50_26.2: i32 = converted %TooMany.call, %.loc50_26.1
// CHECK:STDOUT:   return %.loc50_26.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @RuntimeCallBadReturnType(%a: i32, %b: i32) -> bool {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %BadReturnType.ref: BadReturnType = name_ref BadReturnType, file.%BadReturnType.decl [template = constants.%struct.5]
// CHECK:STDOUT:   %a.ref: i32 = name_ref a, %a
// CHECK:STDOUT:   %b.ref: i32 = name_ref b, %b
// CHECK:STDOUT:   %BadReturnType.call: init bool = call %BadReturnType.ref(%a.ref, %b.ref)
// CHECK:STDOUT:   %.loc54_29.1: bool = value_of_initializer %BadReturnType.call
// CHECK:STDOUT:   %.loc54_29.2: bool = converted %BadReturnType.call, %.loc54_29.1
// CHECK:STDOUT:   return %.loc54_29.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- overflow.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Int32 = struct_value () [template]
// CHECK:STDOUT:   %Add: type = fn_type @Add [template]
// CHECK:STDOUT:   %struct.2: Add = struct_value () [template]
// CHECK:STDOUT:   %.2: i32 = int_literal 2147483647 [template]
// CHECK:STDOUT:   %.3: i32 = int_literal 0 [template]
// CHECK:STDOUT:   %.4: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %.5: i32 = int_literal -2147483648 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Add = %Add.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.2: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.3: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %Add.decl: Add = fn_decl @Add [template = constants.%struct.2] {
// CHECK:STDOUT:     %int.make_type_32.loc4_11: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc4_11.1: type = value_of_initializer %int.make_type_32.loc4_11 [template = i32]
// CHECK:STDOUT:     %.loc4_11.2: type = converted %int.make_type_32.loc4_11, %.loc4_11.1 [template = i32]
// CHECK:STDOUT:     %a.loc4_8.1: i32 = param a
// CHECK:STDOUT:     @Add.%a: i32 = bind_name a, %a.loc4_8.1
// CHECK:STDOUT:     %int.make_type_32.loc4_19: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc4_19.1: type = value_of_initializer %int.make_type_32.loc4_19 [template = i32]
// CHECK:STDOUT:     %.loc4_19.2: type = converted %int.make_type_32.loc4_19, %.loc4_19.1 [template = i32]
// CHECK:STDOUT:     %b.loc4_16.1: i32 = param b
// CHECK:STDOUT:     @Add.%b: i32 = bind_name b, %b.loc4_16.1
// CHECK:STDOUT:     %int.make_type_32.loc4_27: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc4_27.1: type = value_of_initializer %int.make_type_32.loc4_27 [template = i32]
// CHECK:STDOUT:     %.loc4_27.2: type = converted %int.make_type_32.loc4_27, %.loc4_27.1 [template = i32]
// CHECK:STDOUT:     @Add.%return: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.4: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %int.make_type_32.loc7: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %.loc7_8.1: type = value_of_initializer %int.make_type_32.loc7 [template = i32]
// CHECK:STDOUT:   %.loc7_8.2: type = converted %int.make_type_32.loc7, %.loc7_8.1 [template = i32]
// CHECK:STDOUT:   %Add.ref.loc7: Add = name_ref Add, %Add.decl [template = constants.%struct.2]
// CHECK:STDOUT:   %.loc7_18: i32 = int_literal 2147483647 [template = constants.%.2]
// CHECK:STDOUT:   %.loc7_30: i32 = int_literal 0 [template = constants.%.3]
// CHECK:STDOUT:   %int.uadd.loc7: init i32 = call %Add.ref.loc7(%.loc7_18, %.loc7_30) [template = constants.%.2]
// CHECK:STDOUT:   %.loc7_32.1: i32 = value_of_initializer %int.uadd.loc7 [template = constants.%.2]
// CHECK:STDOUT:   %.loc7_32.2: i32 = converted %int.uadd.loc7, %.loc7_32.1 [template = constants.%.2]
// CHECK:STDOUT:   %a.loc7: i32 = bind_name a, %.loc7_32.2
// CHECK:STDOUT:   %import_ref.5: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %int.make_type_32.loc8: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %.loc8_8.1: type = value_of_initializer %int.make_type_32.loc8 [template = i32]
// CHECK:STDOUT:   %.loc8_8.2: type = converted %int.make_type_32.loc8, %.loc8_8.1 [template = i32]
// CHECK:STDOUT:   %Add.ref.loc8: Add = name_ref Add, %Add.decl [template = constants.%struct.2]
// CHECK:STDOUT:   %.loc8_18: i32 = int_literal 2147483647 [template = constants.%.2]
// CHECK:STDOUT:   %.loc8_30: i32 = int_literal 1 [template = constants.%.4]
// CHECK:STDOUT:   %int.uadd.loc8: init i32 = call %Add.ref.loc8(%.loc8_18, %.loc8_30) [template = constants.%.5]
// CHECK:STDOUT:   %.loc8_32.1: i32 = value_of_initializer %int.uadd.loc8 [template = constants.%.5]
// CHECK:STDOUT:   %.loc8_32.2: i32 = converted %int.uadd.loc8, %.loc8_32.1 [template = constants.%.5]
// CHECK:STDOUT:   %b.loc8: i32 = bind_name b, %.loc8_32.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Add(%a: i32, %b: i32) -> i32 = "int.uadd";
// CHECK:STDOUT:
