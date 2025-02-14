// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

fn F() -> (i32, i32, i32);

fn G() {
  var v: {.a: (i32, i32, i32), .b: (i32, i32, i32)} = {.a = F(), .b = F()};
}

// CHECK:STDOUT: --- nested_struct_in_place.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Int32 = struct_value () [template]
// CHECK:STDOUT:   %.2: type = tuple_type (type, type, type) [template]
// CHECK:STDOUT:   %.3: type = tuple_type (i32, i32, i32) [template]
// CHECK:STDOUT:   %F: type = fn_type @F [template]
// CHECK:STDOUT:   %struct.2: F = struct_value () [template]
// CHECK:STDOUT:   %G: type = fn_type @G [template]
// CHECK:STDOUT:   %struct.3: G = struct_value () [template]
// CHECK:STDOUT:   %.4: type = struct_type {.a: (i32, i32, i32), .b: (i32, i32, i32)} [template]
// CHECK:STDOUT:   %.5: type = ptr_type (i32, i32, i32) [template]
// CHECK:STDOUT:   %.6: type = struct_type {.a: (i32, i32, i32)*, .b: (i32, i32, i32)*} [template]
// CHECK:STDOUT:   %.7: type = ptr_type {.a: (i32, i32, i32)*, .b: (i32, i32, i32)*} [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .F = %F.decl
// CHECK:STDOUT:     .G = %G.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.2: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.3: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %F.decl: F = fn_decl @F [template = constants.%struct.2] {
// CHECK:STDOUT:     %int.make_type_32.loc7_12: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %int.make_type_32.loc7_17: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %int.make_type_32.loc7_22: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc7_25.1: (type, type, type) = tuple_literal (%int.make_type_32.loc7_12, %int.make_type_32.loc7_17, %int.make_type_32.loc7_22)
// CHECK:STDOUT:     %.loc7_25.2: type = value_of_initializer %int.make_type_32.loc7_12 [template = i32]
// CHECK:STDOUT:     %.loc7_25.3: type = converted %int.make_type_32.loc7_12, %.loc7_25.2 [template = i32]
// CHECK:STDOUT:     %.loc7_25.4: type = value_of_initializer %int.make_type_32.loc7_17 [template = i32]
// CHECK:STDOUT:     %.loc7_25.5: type = converted %int.make_type_32.loc7_17, %.loc7_25.4 [template = i32]
// CHECK:STDOUT:     %.loc7_25.6: type = value_of_initializer %int.make_type_32.loc7_22 [template = i32]
// CHECK:STDOUT:     %.loc7_25.7: type = converted %int.make_type_32.loc7_22, %.loc7_25.6 [template = i32]
// CHECK:STDOUT:     %.loc7_25.8: type = converted %.loc7_25.1, constants.%.3 [template = constants.%.3]
// CHECK:STDOUT:     @F.%return: ref (i32, i32, i32) = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %G.decl: G = fn_decl @G [template = constants.%struct.3] {}
// CHECK:STDOUT:   %import_ref.4: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.5: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.6: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.7: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.8: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.9: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F() -> (i32, i32, i32);
// CHECK:STDOUT:
// CHECK:STDOUT: fn @G() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %int.make_type_32.loc10_16: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %int.make_type_32.loc10_21: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %int.make_type_32.loc10_26: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %.loc10_29.1: (type, type, type) = tuple_literal (%int.make_type_32.loc10_16, %int.make_type_32.loc10_21, %int.make_type_32.loc10_26)
// CHECK:STDOUT:   %.loc10_29.2: type = value_of_initializer %int.make_type_32.loc10_16 [template = i32]
// CHECK:STDOUT:   %.loc10_29.3: type = converted %int.make_type_32.loc10_16, %.loc10_29.2 [template = i32]
// CHECK:STDOUT:   %.loc10_29.4: type = value_of_initializer %int.make_type_32.loc10_21 [template = i32]
// CHECK:STDOUT:   %.loc10_29.5: type = converted %int.make_type_32.loc10_21, %.loc10_29.4 [template = i32]
// CHECK:STDOUT:   %.loc10_29.6: type = value_of_initializer %int.make_type_32.loc10_26 [template = i32]
// CHECK:STDOUT:   %.loc10_29.7: type = converted %int.make_type_32.loc10_26, %.loc10_29.6 [template = i32]
// CHECK:STDOUT:   %.loc10_29.8: type = converted %.loc10_29.1, constants.%.3 [template = constants.%.3]
// CHECK:STDOUT:   %int.make_type_32.loc10_37: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %int.make_type_32.loc10_42: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %int.make_type_32.loc10_47: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %.loc10_50.1: (type, type, type) = tuple_literal (%int.make_type_32.loc10_37, %int.make_type_32.loc10_42, %int.make_type_32.loc10_47)
// CHECK:STDOUT:   %.loc10_50.2: type = value_of_initializer %int.make_type_32.loc10_37 [template = i32]
// CHECK:STDOUT:   %.loc10_50.3: type = converted %int.make_type_32.loc10_37, %.loc10_50.2 [template = i32]
// CHECK:STDOUT:   %.loc10_50.4: type = value_of_initializer %int.make_type_32.loc10_42 [template = i32]
// CHECK:STDOUT:   %.loc10_50.5: type = converted %int.make_type_32.loc10_42, %.loc10_50.4 [template = i32]
// CHECK:STDOUT:   %.loc10_50.6: type = value_of_initializer %int.make_type_32.loc10_47 [template = i32]
// CHECK:STDOUT:   %.loc10_50.7: type = converted %int.make_type_32.loc10_47, %.loc10_50.6 [template = i32]
// CHECK:STDOUT:   %.loc10_50.8: type = converted %.loc10_50.1, constants.%.3 [template = constants.%.3]
// CHECK:STDOUT:   %.loc10_51: type = struct_type {.a: (i32, i32, i32), .b: (i32, i32, i32)} [template = constants.%.4]
// CHECK:STDOUT:   %v.var: ref {.a: (i32, i32, i32), .b: (i32, i32, i32)} = var v
// CHECK:STDOUT:   %v: ref {.a: (i32, i32, i32), .b: (i32, i32, i32)} = bind_name v, %v.var
// CHECK:STDOUT:   %F.ref.loc10_61: F = name_ref F, file.%F.decl [template = constants.%struct.2]
// CHECK:STDOUT:   %.loc10_74.1: ref (i32, i32, i32) = struct_access %v.var, element0
// CHECK:STDOUT:   %F.call.loc10_62: init (i32, i32, i32) = call %F.ref.loc10_61() to %.loc10_74.1
// CHECK:STDOUT:   %F.ref.loc10_71: F = name_ref F, file.%F.decl [template = constants.%struct.2]
// CHECK:STDOUT:   %.loc10_74.2: ref (i32, i32, i32) = struct_access %v.var, element1
// CHECK:STDOUT:   %F.call.loc10_72: init (i32, i32, i32) = call %F.ref.loc10_71() to %.loc10_74.2
// CHECK:STDOUT:   %.loc10_74.3: {.a: (i32, i32, i32), .b: (i32, i32, i32)} = struct_literal (%F.call.loc10_62, %F.call.loc10_72)
// CHECK:STDOUT:   %.loc10_74.4: init {.a: (i32, i32, i32), .b: (i32, i32, i32)} = struct_init (%F.call.loc10_62, %F.call.loc10_72) to %v.var
// CHECK:STDOUT:   %.loc10_75: init {.a: (i32, i32, i32), .b: (i32, i32, i32)} = converted %.loc10_74.3, %.loc10_74.4
// CHECK:STDOUT:   assign %v.var, %.loc10_75
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
