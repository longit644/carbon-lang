// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

fn Main() -> i32 {
  // The following line has two mismatches, but after the first, it shouldn't
  // keep erroring.
  // CHECK:STDERR: fail_type_mismatch_once.carbon:[[@LINE+7]]:10: ERROR: Cannot access member of interface Add in type i32 that does not implement that interface.
  // CHECK:STDERR:   return 12 + 3.4 + 12;
  // CHECK:STDERR:          ^~~~~~~~
  // CHECK:STDERR:
  // CHECK:STDERR: fail_type_mismatch_once.carbon:[[@LINE+3]]:10: ERROR: Cannot access member of interface Add in type <error> that does not implement that interface.
  // CHECK:STDERR:   return 12 + 3.4 + 12;
  // CHECK:STDERR:          ^~~~~~~~~~~~~
  return 12 + 3.4 + 12;
}

// CHECK:STDOUT: --- fail_type_mismatch_once.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Int32 = struct_value () [template]
// CHECK:STDOUT:   %Main: type = fn_type @Main [template]
// CHECK:STDOUT:   %struct.2: Main = struct_value () [template]
// CHECK:STDOUT:   %.2: i32 = int_literal 12 [template]
// CHECK:STDOUT:   %.3: f64 = float_literal 3.4000000000000004 [template]
// CHECK:STDOUT:   %.4: type = interface_type @Add [template]
// CHECK:STDOUT:   %Self: Add = bind_symbolic_name Self 0 [symbolic]
// CHECK:STDOUT:   %Op: type = fn_type @Op [template]
// CHECK:STDOUT:   %struct.3: Op = struct_value () [template]
// CHECK:STDOUT:   %.5: type = assoc_entity_type @Add, Op [template]
// CHECK:STDOUT:   %.6: <associated Op in Add> = assoc_entity element0, file.%import_ref.6 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Main = %Main.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %Main.decl: Main = fn_decl @Main [template = constants.%struct.2] {
// CHECK:STDOUT:     %int.make_type_32: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc7_14.1: type = value_of_initializer %int.make_type_32 [template = i32]
// CHECK:STDOUT:     %.loc7_14.2: type = converted %int.make_type_32, %.loc7_14.1 [template = i32]
// CHECK:STDOUT:     @Main.%return: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.2: type = import_ref ir4, inst+1, loaded [template = constants.%.4]
// CHECK:STDOUT:   %import_ref.3 = import_ref ir4, inst+3, unloaded
// CHECK:STDOUT:   %import_ref.4: <associated Op in Add> = import_ref ir4, inst+24, loaded [template = constants.%.6]
// CHECK:STDOUT:   %import_ref.5 = import_ref ir4, inst+19, unloaded
// CHECK:STDOUT:   %import_ref.6 = import_ref ir4, inst+19, unloaded
// CHECK:STDOUT:   %import_ref.7: type = import_ref ir4, inst+1, loaded [template = constants.%.4]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: interface @Add {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = file.%import_ref.3
// CHECK:STDOUT:   .Op = file.%import_ref.4
// CHECK:STDOUT:   witness = (file.%import_ref.5)
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Main() -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc17_10: i32 = int_literal 12 [template = constants.%.2]
// CHECK:STDOUT:   %.loc17_15: f64 = float_literal 3.4000000000000004 [template = constants.%.3]
// CHECK:STDOUT:   %.loc17_21: i32 = int_literal 12 [template = constants.%.2]
// CHECK:STDOUT:   return <error>
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Op[%self: Self](%other: Self) -> Self;
// CHECK:STDOUT:
