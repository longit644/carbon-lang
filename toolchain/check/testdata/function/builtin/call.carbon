// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

fn Add(a: i32, b: i32) -> i32 = "int.sadd";

var arr: [i32; Add(1, 2)];

// CHECK:STDOUT: --- call.carbon
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
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Add = %Add.decl
// CHECK:STDOUT:     .arr = %arr
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.2: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.3: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %Add.decl: Add = fn_decl @Add [template = constants.%struct.2] {
// CHECK:STDOUT:     %int.make_type_32.loc7_11: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc7_11.1: type = value_of_initializer %int.make_type_32.loc7_11 [template = i32]
// CHECK:STDOUT:     %.loc7_11.2: type = converted %int.make_type_32.loc7_11, %.loc7_11.1 [template = i32]
// CHECK:STDOUT:     %a.loc7_8.1: i32 = param a
// CHECK:STDOUT:     @Add.%a: i32 = bind_name a, %a.loc7_8.1
// CHECK:STDOUT:     %int.make_type_32.loc7_19: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc7_19.1: type = value_of_initializer %int.make_type_32.loc7_19 [template = i32]
// CHECK:STDOUT:     %.loc7_19.2: type = converted %int.make_type_32.loc7_19, %.loc7_19.1 [template = i32]
// CHECK:STDOUT:     %b.loc7_16.1: i32 = param b
// CHECK:STDOUT:     @Add.%b: i32 = bind_name b, %b.loc7_16.1
// CHECK:STDOUT:     %int.make_type_32.loc7_27: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc7_27.1: type = value_of_initializer %int.make_type_32.loc7_27 [template = i32]
// CHECK:STDOUT:     %.loc7_27.2: type = converted %int.make_type_32.loc7_27, %.loc7_27.1 [template = i32]
// CHECK:STDOUT:     @Add.%return: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.4: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %int.make_type_32.loc9: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %Add.ref: Add = name_ref Add, %Add.decl [template = constants.%struct.2]
// CHECK:STDOUT:   %.loc9_20: i32 = int_literal 1 [template = constants.%.2]
// CHECK:STDOUT:   %.loc9_23: i32 = int_literal 2 [template = constants.%.3]
// CHECK:STDOUT:   %int.sadd: init i32 = call %Add.ref(%.loc9_20, %.loc9_23) [template = constants.%.4]
// CHECK:STDOUT:   %.loc9_11.1: type = value_of_initializer %int.make_type_32.loc9 [template = i32]
// CHECK:STDOUT:   %.loc9_11.2: type = converted %int.make_type_32.loc9, %.loc9_11.1 [template = i32]
// CHECK:STDOUT:   %.loc9_25: type = array_type %int.sadd, i32 [template = constants.%.5]
// CHECK:STDOUT:   %arr.var: ref [i32; 3] = var arr
// CHECK:STDOUT:   %arr: ref [i32; 3] = bind_name arr, %arr.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Add(%a: i32, %b: i32) -> i32 = "int.sadd";
// CHECK:STDOUT:
