// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// --- core.carbon

package Core library "test";

fn Int32() -> type = "int.make_type_32";
fn TestAdd(a: i32, b: i32) -> i32 = "int.sadd";

// --- use.carbon

import Core library "test";

var arr: [i32; Core.TestAdd(1, 2)] = (1, 2, 3);

// CHECK:STDOUT: --- core.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Int32 = struct_value () [template]
// CHECK:STDOUT:   %TestAdd: type = fn_type @TestAdd [template]
// CHECK:STDOUT:   %struct.2: TestAdd = struct_value () [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Int32 = %Int32.decl
// CHECK:STDOUT:     .TestAdd = %TestAdd.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Int32.decl: Int32 = fn_decl @Int32 [template = constants.%struct.1] {
// CHECK:STDOUT:     @Int32.%return: ref type = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %TestAdd.decl: TestAdd = fn_decl @TestAdd [template = constants.%struct.2] {
// CHECK:STDOUT:     %int.make_type_32.loc5_15: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc5_15.1: type = value_of_initializer %int.make_type_32.loc5_15 [template = i32]
// CHECK:STDOUT:     %.loc5_15.2: type = converted %int.make_type_32.loc5_15, %.loc5_15.1 [template = i32]
// CHECK:STDOUT:     %a.loc5_12.1: i32 = param a
// CHECK:STDOUT:     @TestAdd.%a: i32 = bind_name a, %a.loc5_12.1
// CHECK:STDOUT:     %int.make_type_32.loc5_23: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc5_23.1: type = value_of_initializer %int.make_type_32.loc5_23 [template = i32]
// CHECK:STDOUT:     %.loc5_23.2: type = converted %int.make_type_32.loc5_23, %.loc5_23.1 [template = i32]
// CHECK:STDOUT:     %b.loc5_20.1: i32 = param b
// CHECK:STDOUT:     @TestAdd.%b: i32 = bind_name b, %b.loc5_20.1
// CHECK:STDOUT:     %int.make_type_32.loc5_31: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc5_31.1: type = value_of_initializer %int.make_type_32.loc5_31 [template = i32]
// CHECK:STDOUT:     %.loc5_31.2: type = converted %int.make_type_32.loc5_31, %.loc5_31.1 [template = i32]
// CHECK:STDOUT:     @TestAdd.%return: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @TestAdd(%a: i32, %b: i32) -> i32 = "int.sadd";
// CHECK:STDOUT:
// CHECK:STDOUT: --- use.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Int32 = struct_value () [template]
// CHECK:STDOUT:   %TestAdd: type = fn_type @TestAdd [template]
// CHECK:STDOUT:   %struct.2: TestAdd = struct_value () [template]
// CHECK:STDOUT:   %.2: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %.3: i32 = int_literal 2 [template]
// CHECK:STDOUT:   %.4: i32 = int_literal 3 [template]
// CHECK:STDOUT:   %.5: type = array_type %.4, i32 [template]
// CHECK:STDOUT:   %.6: type = ptr_type [i32; 3] [template]
// CHECK:STDOUT:   %.7: type = tuple_type (i32, i32, i32) [template]
// CHECK:STDOUT:   %.8: i32 = int_literal 0 [template]
// CHECK:STDOUT:   %array: [i32; 3] = tuple_value (%.2, %.3, %.4) [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .arr = %arr
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir1, inst+2, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %int.make_type_32: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %Core.ref: <namespace> = name_ref Core, %Core [template = %Core]
// CHECK:STDOUT:   %import_ref.2: TestAdd = import_ref ir1, inst+20, loaded [template = constants.%struct.2]
// CHECK:STDOUT:   %TestAdd.ref: TestAdd = name_ref TestAdd, %import_ref.2 [template = constants.%struct.2]
// CHECK:STDOUT:   %.loc4_29: i32 = int_literal 1 [template = constants.%.2]
// CHECK:STDOUT:   %.loc4_32: i32 = int_literal 2 [template = constants.%.3]
// CHECK:STDOUT:   %int.sadd: init i32 = call %TestAdd.ref(%.loc4_29, %.loc4_32) [template = constants.%.4]
// CHECK:STDOUT:   %.loc4_11.1: type = value_of_initializer %int.make_type_32 [template = i32]
// CHECK:STDOUT:   %.loc4_11.2: type = converted %int.make_type_32, %.loc4_11.1 [template = i32]
// CHECK:STDOUT:   %.loc4_34: type = array_type %int.sadd, i32 [template = constants.%.5]
// CHECK:STDOUT:   %arr.var: ref [i32; 3] = var arr
// CHECK:STDOUT:   %arr: ref [i32; 3] = bind_name arr, %arr.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @TestAdd(%a: i32, %b: i32) -> i32 = "int.sadd";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @__global_init() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc4_39: i32 = int_literal 1 [template = constants.%.2]
// CHECK:STDOUT:   %.loc4_42: i32 = int_literal 2 [template = constants.%.3]
// CHECK:STDOUT:   %.loc4_45: i32 = int_literal 3 [template = constants.%.4]
// CHECK:STDOUT:   %.loc4_46.1: (i32, i32, i32) = tuple_literal (%.loc4_39, %.loc4_42, %.loc4_45)
// CHECK:STDOUT:   %.loc4_46.2: i32 = int_literal 0 [template = constants.%.8]
// CHECK:STDOUT:   %.loc4_46.3: ref i32 = array_index file.%arr.var, %.loc4_46.2
// CHECK:STDOUT:   %.loc4_46.4: init i32 = initialize_from %.loc4_39 to %.loc4_46.3 [template = constants.%.2]
// CHECK:STDOUT:   %.loc4_46.5: i32 = int_literal 1 [template = constants.%.2]
// CHECK:STDOUT:   %.loc4_46.6: ref i32 = array_index file.%arr.var, %.loc4_46.5
// CHECK:STDOUT:   %.loc4_46.7: init i32 = initialize_from %.loc4_42 to %.loc4_46.6 [template = constants.%.3]
// CHECK:STDOUT:   %.loc4_46.8: i32 = int_literal 2 [template = constants.%.3]
// CHECK:STDOUT:   %.loc4_46.9: ref i32 = array_index file.%arr.var, %.loc4_46.8
// CHECK:STDOUT:   %.loc4_46.10: init i32 = initialize_from %.loc4_45 to %.loc4_46.9 [template = constants.%.4]
// CHECK:STDOUT:   %.loc4_46.11: init [i32; 3] = array_init (%.loc4_46.4, %.loc4_46.7, %.loc4_46.10) to file.%arr.var [template = constants.%array]
// CHECK:STDOUT:   %.loc4_47: init [i32; 3] = converted %.loc4_46.1, %.loc4_46.11 [template = constants.%array]
// CHECK:STDOUT:   assign file.%arr.var, %.loc4_47
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
