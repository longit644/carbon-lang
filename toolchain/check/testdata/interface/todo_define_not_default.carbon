// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

interface I {
  // TODO: A definition without `default` in an interface should be rejected.
  fn F() {}
  fn G(a: i32, b: i32) -> i32 = "int.sadd";

  // TODO: An associated constant with an initializer without `default` in an
  // interface should be rejected.
  let T:! type = (i32, i32);
  let N:! i32 = 42;
}

// CHECK:STDOUT: --- todo_define_not_default.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %.1: type = interface_type @I [template]
// CHECK:STDOUT:   %Self: I = bind_symbolic_name Self 0 [symbolic]
// CHECK:STDOUT:   %F: type = fn_type @F [template]
// CHECK:STDOUT:   %.2: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: F = struct_value () [template]
// CHECK:STDOUT:   %.3: type = assoc_entity_type @I, F [template]
// CHECK:STDOUT:   %.4: <associated F in I> = assoc_entity element0, @I.%F.decl [template]
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %struct.2: Int32 = struct_value () [template]
// CHECK:STDOUT:   %G: type = fn_type @G [template]
// CHECK:STDOUT:   %struct.3: G = struct_value () [template]
// CHECK:STDOUT:   %.5: type = assoc_entity_type @I, G [template]
// CHECK:STDOUT:   %.6: <associated G in I> = assoc_entity element1, @I.%G.decl [template]
// CHECK:STDOUT:   %.7: type = tuple_type (type, type) [template]
// CHECK:STDOUT:   %.8: type = tuple_type (i32, i32) [template]
// CHECK:STDOUT:   %.9: type = assoc_entity_type @I, type [template]
// CHECK:STDOUT:   %.10: <associated type in I> = assoc_entity element2, @I.%T [template]
// CHECK:STDOUT:   %.11: i32 = int_literal 42 [template]
// CHECK:STDOUT:   %.12: type = assoc_entity_type @I, i32 [template]
// CHECK:STDOUT:   %.13: <associated i32 in I> = assoc_entity element3, @I.%N [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .I = %I.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %I.decl: type = interface_decl @I [template = constants.%.1] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.2]
// CHECK:STDOUT:   %import_ref.2: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.2]
// CHECK:STDOUT:   %import_ref.3: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.2]
// CHECK:STDOUT:   %import_ref.4: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.2]
// CHECK:STDOUT:   %import_ref.5: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.2]
// CHECK:STDOUT:   %import_ref.6: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.2]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: interface @I {
// CHECK:STDOUT:   %Self: I = bind_symbolic_name Self 0 [symbolic = constants.%Self]
// CHECK:STDOUT:   %F.decl: F = fn_decl @F [template = constants.%struct.1] {}
// CHECK:STDOUT:   %.loc9: <associated F in I> = assoc_entity element0, %F.decl [template = constants.%.4]
// CHECK:STDOUT:   %G.decl: G = fn_decl @G [template = constants.%struct.3] {
// CHECK:STDOUT:     %int.make_type_32.loc10_11: init type = call constants.%struct.2() [template = i32]
// CHECK:STDOUT:     %.loc10_11.1: type = value_of_initializer %int.make_type_32.loc10_11 [template = i32]
// CHECK:STDOUT:     %.loc10_11.2: type = converted %int.make_type_32.loc10_11, %.loc10_11.1 [template = i32]
// CHECK:STDOUT:     %a.loc10_8.1: i32 = param a
// CHECK:STDOUT:     %a.loc10_8.2: i32 = bind_name a, %a.loc10_8.1
// CHECK:STDOUT:     %int.make_type_32.loc10_19: init type = call constants.%struct.2() [template = i32]
// CHECK:STDOUT:     %.loc10_19.1: type = value_of_initializer %int.make_type_32.loc10_19 [template = i32]
// CHECK:STDOUT:     %.loc10_19.2: type = converted %int.make_type_32.loc10_19, %.loc10_19.1 [template = i32]
// CHECK:STDOUT:     %b.loc10_16.1: i32 = param b
// CHECK:STDOUT:     %b.loc10_16.2: i32 = bind_name b, %b.loc10_16.1
// CHECK:STDOUT:     %int.make_type_32.loc10_27: init type = call constants.%struct.2() [template = i32]
// CHECK:STDOUT:     %.loc10_27.1: type = value_of_initializer %int.make_type_32.loc10_27 [template = i32]
// CHECK:STDOUT:     %.loc10_27.2: type = converted %int.make_type_32.loc10_27, %.loc10_27.1 [template = i32]
// CHECK:STDOUT:     %return.var: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %.loc10_31: <associated G in I> = assoc_entity element1, %G.decl [template = constants.%.6]
// CHECK:STDOUT:   %int.make_type_32.loc14_19: init type = call constants.%struct.2() [template = i32]
// CHECK:STDOUT:   %int.make_type_32.loc14_24: init type = call constants.%struct.2() [template = i32]
// CHECK:STDOUT:   %.loc14_27: (type, type) = tuple_literal (%int.make_type_32.loc14_19, %int.make_type_32.loc14_24)
// CHECK:STDOUT:   %.loc14_28.1: type = value_of_initializer %int.make_type_32.loc14_19 [template = i32]
// CHECK:STDOUT:   %.loc14_28.2: type = converted %int.make_type_32.loc14_19, %.loc14_28.1 [template = i32]
// CHECK:STDOUT:   %.loc14_28.3: type = value_of_initializer %int.make_type_32.loc14_24 [template = i32]
// CHECK:STDOUT:   %.loc14_28.4: type = converted %int.make_type_32.loc14_24, %.loc14_28.3 [template = i32]
// CHECK:STDOUT:   %.loc14_28.5: type = converted %.loc14_27, constants.%.8 [template = constants.%.8]
// CHECK:STDOUT:   %T: type = assoc_const_decl T [template]
// CHECK:STDOUT:   %.loc14_28.6: <associated type in I> = assoc_entity element2, %T [template = constants.%.10]
// CHECK:STDOUT:   %int.make_type_32.loc15: init type = call constants.%struct.2() [template = i32]
// CHECK:STDOUT:   %.loc15_11.1: type = value_of_initializer %int.make_type_32.loc15 [template = i32]
// CHECK:STDOUT:   %.loc15_11.2: type = converted %int.make_type_32.loc15, %.loc15_11.1 [template = i32]
// CHECK:STDOUT:   %.loc15_17: i32 = int_literal 42 [template = constants.%.11]
// CHECK:STDOUT:   %N: i32 = assoc_const_decl N [template]
// CHECK:STDOUT:   %.loc15_19: <associated i32 in I> = assoc_entity element3, %N [template = constants.%.13]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = %Self
// CHECK:STDOUT:   .F = %.loc9
// CHECK:STDOUT:   .G = %.loc10_31
// CHECK:STDOUT:   .T = %.loc14_28.6
// CHECK:STDOUT:   .N = %.loc15_19
// CHECK:STDOUT:   witness = (%F.decl, %G.decl, %T, %N)
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @G(@I.%a.loc10_8.2: i32, @I.%b.loc10_16.2: i32) -> i32 = "int.sadd";
// CHECK:STDOUT:
