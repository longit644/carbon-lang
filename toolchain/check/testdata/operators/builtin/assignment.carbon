// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

fn Main() {
  var a: i32 = 12;
  a = 9;

  var b: (i32, i32) = (1, 2);
  b[0] = 3;
  b[1] = 4;

  var c: {.a: i32, .b: i32} = {.a = 1, .b = 2};
  c.a = 3;
  c.b = 4;

  var p: i32* = &a;
  *p = 5;

  *(if true then p else &a) = 10;
}

// CHECK:STDOUT: --- assignment.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Main: type = fn_type @Main [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Main = struct_value () [template]
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %struct.2: Int32 = struct_value () [template]
// CHECK:STDOUT:   %.2: i32 = int_literal 12 [template]
// CHECK:STDOUT:   %.3: i32 = int_literal 9 [template]
// CHECK:STDOUT:   %.4: type = tuple_type (type, type) [template]
// CHECK:STDOUT:   %.5: type = tuple_type (i32, i32) [template]
// CHECK:STDOUT:   %.6: type = ptr_type (i32, i32) [template]
// CHECK:STDOUT:   %.7: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %.8: i32 = int_literal 2 [template]
// CHECK:STDOUT:   %tuple: (i32, i32) = tuple_value (%.7, %.8) [template]
// CHECK:STDOUT:   %.9: i32 = int_literal 0 [template]
// CHECK:STDOUT:   %.10: i32 = int_literal 3 [template]
// CHECK:STDOUT:   %.11: i32 = int_literal 4 [template]
// CHECK:STDOUT:   %.12: type = struct_type {.a: i32, .b: i32} [template]
// CHECK:STDOUT:   %.13: type = ptr_type {.a: i32, .b: i32} [template]
// CHECK:STDOUT:   %struct.3: {.a: i32, .b: i32} = struct_value (%.7, %.8) [template]
// CHECK:STDOUT:   %.14: type = ptr_type i32 [template]
// CHECK:STDOUT:   %.15: i32 = int_literal 5 [template]
// CHECK:STDOUT:   %.16: bool = bool_literal true [template]
// CHECK:STDOUT:   %.17: i32 = int_literal 10 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Main = %Main.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %Main.decl: Main = fn_decl @Main [template = constants.%struct.1] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.2]
// CHECK:STDOUT:   %import_ref.2: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.2]
// CHECK:STDOUT:   %import_ref.3: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.2]
// CHECK:STDOUT:   %import_ref.4: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.2]
// CHECK:STDOUT:   %import_ref.5: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.2]
// CHECK:STDOUT:   %import_ref.6: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.2]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Main() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %int.make_type_32.loc8: init type = call constants.%struct.2() [template = i32]
// CHECK:STDOUT:   %.loc8_10.1: type = value_of_initializer %int.make_type_32.loc8 [template = i32]
// CHECK:STDOUT:   %.loc8_10.2: type = converted %int.make_type_32.loc8, %.loc8_10.1 [template = i32]
// CHECK:STDOUT:   %a.var: ref i32 = var a
// CHECK:STDOUT:   %a: ref i32 = bind_name a, %a.var
// CHECK:STDOUT:   %.loc8_16: i32 = int_literal 12 [template = constants.%.2]
// CHECK:STDOUT:   assign %a.var, %.loc8_16
// CHECK:STDOUT:   %a.ref.loc9: ref i32 = name_ref a, %a
// CHECK:STDOUT:   %.loc9: i32 = int_literal 9 [template = constants.%.3]
// CHECK:STDOUT:   assign %a.ref.loc9, %.loc9
// CHECK:STDOUT:   %int.make_type_32.loc11_11: init type = call constants.%struct.2() [template = i32]
// CHECK:STDOUT:   %int.make_type_32.loc11_16: init type = call constants.%struct.2() [template = i32]
// CHECK:STDOUT:   %.loc11_19.1: (type, type) = tuple_literal (%int.make_type_32.loc11_11, %int.make_type_32.loc11_16)
// CHECK:STDOUT:   %.loc11_19.2: type = value_of_initializer %int.make_type_32.loc11_11 [template = i32]
// CHECK:STDOUT:   %.loc11_19.3: type = converted %int.make_type_32.loc11_11, %.loc11_19.2 [template = i32]
// CHECK:STDOUT:   %.loc11_19.4: type = value_of_initializer %int.make_type_32.loc11_16 [template = i32]
// CHECK:STDOUT:   %.loc11_19.5: type = converted %int.make_type_32.loc11_16, %.loc11_19.4 [template = i32]
// CHECK:STDOUT:   %.loc11_19.6: type = converted %.loc11_19.1, constants.%.5 [template = constants.%.5]
// CHECK:STDOUT:   %b.var: ref (i32, i32) = var b
// CHECK:STDOUT:   %b: ref (i32, i32) = bind_name b, %b.var
// CHECK:STDOUT:   %.loc11_24: i32 = int_literal 1 [template = constants.%.7]
// CHECK:STDOUT:   %.loc11_27: i32 = int_literal 2 [template = constants.%.8]
// CHECK:STDOUT:   %.loc11_28.1: (i32, i32) = tuple_literal (%.loc11_24, %.loc11_27)
// CHECK:STDOUT:   %.loc11_28.2: ref i32 = tuple_access %b.var, element0
// CHECK:STDOUT:   %.loc11_28.3: init i32 = initialize_from %.loc11_24 to %.loc11_28.2 [template = constants.%.7]
// CHECK:STDOUT:   %.loc11_28.4: ref i32 = tuple_access %b.var, element1
// CHECK:STDOUT:   %.loc11_28.5: init i32 = initialize_from %.loc11_27 to %.loc11_28.4 [template = constants.%.8]
// CHECK:STDOUT:   %.loc11_28.6: init (i32, i32) = tuple_init (%.loc11_28.3, %.loc11_28.5) to %b.var [template = constants.%tuple]
// CHECK:STDOUT:   %.loc11_29: init (i32, i32) = converted %.loc11_28.1, %.loc11_28.6 [template = constants.%tuple]
// CHECK:STDOUT:   assign %b.var, %.loc11_29
// CHECK:STDOUT:   %b.ref.loc12: ref (i32, i32) = name_ref b, %b
// CHECK:STDOUT:   %.loc12_5: i32 = int_literal 0 [template = constants.%.9]
// CHECK:STDOUT:   %.loc12_6: ref i32 = tuple_index %b.ref.loc12, %.loc12_5
// CHECK:STDOUT:   %.loc12_10: i32 = int_literal 3 [template = constants.%.10]
// CHECK:STDOUT:   assign %.loc12_6, %.loc12_10
// CHECK:STDOUT:   %b.ref.loc13: ref (i32, i32) = name_ref b, %b
// CHECK:STDOUT:   %.loc13_5: i32 = int_literal 1 [template = constants.%.7]
// CHECK:STDOUT:   %.loc13_6: ref i32 = tuple_index %b.ref.loc13, %.loc13_5
// CHECK:STDOUT:   %.loc13_10: i32 = int_literal 4 [template = constants.%.11]
// CHECK:STDOUT:   assign %.loc13_6, %.loc13_10
// CHECK:STDOUT:   %int.make_type_32.loc15_15: init type = call constants.%struct.2() [template = i32]
// CHECK:STDOUT:   %.loc15_15.1: type = value_of_initializer %int.make_type_32.loc15_15 [template = i32]
// CHECK:STDOUT:   %.loc15_15.2: type = converted %int.make_type_32.loc15_15, %.loc15_15.1 [template = i32]
// CHECK:STDOUT:   %int.make_type_32.loc15_24: init type = call constants.%struct.2() [template = i32]
// CHECK:STDOUT:   %.loc15_24.1: type = value_of_initializer %int.make_type_32.loc15_24 [template = i32]
// CHECK:STDOUT:   %.loc15_24.2: type = converted %int.make_type_32.loc15_24, %.loc15_24.1 [template = i32]
// CHECK:STDOUT:   %.loc15_27: type = struct_type {.a: i32, .b: i32} [template = constants.%.12]
// CHECK:STDOUT:   %c.var: ref {.a: i32, .b: i32} = var c
// CHECK:STDOUT:   %c: ref {.a: i32, .b: i32} = bind_name c, %c.var
// CHECK:STDOUT:   %.loc15_37: i32 = int_literal 1 [template = constants.%.7]
// CHECK:STDOUT:   %.loc15_45: i32 = int_literal 2 [template = constants.%.8]
// CHECK:STDOUT:   %.loc15_46.1: {.a: i32, .b: i32} = struct_literal (%.loc15_37, %.loc15_45)
// CHECK:STDOUT:   %.loc15_46.2: ref i32 = struct_access %c.var, element0
// CHECK:STDOUT:   %.loc15_46.3: init i32 = initialize_from %.loc15_37 to %.loc15_46.2 [template = constants.%.7]
// CHECK:STDOUT:   %.loc15_46.4: ref i32 = struct_access %c.var, element1
// CHECK:STDOUT:   %.loc15_46.5: init i32 = initialize_from %.loc15_45 to %.loc15_46.4 [template = constants.%.8]
// CHECK:STDOUT:   %.loc15_46.6: init {.a: i32, .b: i32} = struct_init (%.loc15_46.3, %.loc15_46.5) to %c.var [template = constants.%struct.3]
// CHECK:STDOUT:   %.loc15_47: init {.a: i32, .b: i32} = converted %.loc15_46.1, %.loc15_46.6 [template = constants.%struct.3]
// CHECK:STDOUT:   assign %c.var, %.loc15_47
// CHECK:STDOUT:   %c.ref.loc16: ref {.a: i32, .b: i32} = name_ref c, %c
// CHECK:STDOUT:   %.loc16_4: ref i32 = struct_access %c.ref.loc16, element0
// CHECK:STDOUT:   %.loc16_9: i32 = int_literal 3 [template = constants.%.10]
// CHECK:STDOUT:   assign %.loc16_4, %.loc16_9
// CHECK:STDOUT:   %c.ref.loc17: ref {.a: i32, .b: i32} = name_ref c, %c
// CHECK:STDOUT:   %.loc17_4: ref i32 = struct_access %c.ref.loc17, element1
// CHECK:STDOUT:   %.loc17_9: i32 = int_literal 4 [template = constants.%.11]
// CHECK:STDOUT:   assign %.loc17_4, %.loc17_9
// CHECK:STDOUT:   %int.make_type_32.loc19: init type = call constants.%struct.2() [template = i32]
// CHECK:STDOUT:   %.loc19_13.1: type = value_of_initializer %int.make_type_32.loc19 [template = i32]
// CHECK:STDOUT:   %.loc19_13.2: type = converted %int.make_type_32.loc19, %.loc19_13.1 [template = i32]
// CHECK:STDOUT:   %.loc19_13.3: type = ptr_type i32 [template = constants.%.14]
// CHECK:STDOUT:   %p.var: ref i32* = var p
// CHECK:STDOUT:   %p: ref i32* = bind_name p, %p.var
// CHECK:STDOUT:   %a.ref.loc19: ref i32 = name_ref a, %a
// CHECK:STDOUT:   %.loc19_17: i32* = addr_of %a.ref.loc19
// CHECK:STDOUT:   assign %p.var, %.loc19_17
// CHECK:STDOUT:   %p.ref.loc20: ref i32* = name_ref p, %p
// CHECK:STDOUT:   %.loc20_4: i32* = bind_value %p.ref.loc20
// CHECK:STDOUT:   %.loc20_3: ref i32 = deref %.loc20_4
// CHECK:STDOUT:   %.loc20_8: i32 = int_literal 5 [template = constants.%.15]
// CHECK:STDOUT:   assign %.loc20_3, %.loc20_8
// CHECK:STDOUT:   %.loc22_8: bool = bool_literal true [template = constants.%.16]
// CHECK:STDOUT:   if %.loc22_8 br !if.expr.then else br !if.expr.else
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.then:
// CHECK:STDOUT:   %p.ref.loc22: ref i32* = name_ref p, %p
// CHECK:STDOUT:   %.loc22_18: i32* = bind_value %p.ref.loc22
// CHECK:STDOUT:   br !if.expr.result(%.loc22_18)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.else:
// CHECK:STDOUT:   %a.ref.loc22: ref i32 = name_ref a, %a
// CHECK:STDOUT:   %.loc22_25: i32* = addr_of %a.ref.loc22
// CHECK:STDOUT:   br !if.expr.result(%.loc22_25)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.result:
// CHECK:STDOUT:   %.loc22_5: i32* = block_arg !if.expr.result
// CHECK:STDOUT:   %.loc22_3: ref i32 = deref %.loc22_5
// CHECK:STDOUT:   %.loc22_31: i32 = int_literal 10 [template = constants.%.17]
// CHECK:STDOUT:   assign %.loc22_3, %.loc22_31
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
