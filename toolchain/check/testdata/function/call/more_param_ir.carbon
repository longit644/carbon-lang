// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

fn Foo(a: i32, b: i32) {}

fn Main() {
  var x: (i32,) = (1,);
  // Generates multiple IR instructions for the first parameter.
  Foo(x[0], 6);
}

// CHECK:STDOUT: --- more_param_ir.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Int32 = struct_value () [template]
// CHECK:STDOUT:   %Foo: type = fn_type @Foo [template]
// CHECK:STDOUT:   %struct.2: Foo = struct_value () [template]
// CHECK:STDOUT:   %Main: type = fn_type @Main [template]
// CHECK:STDOUT:   %struct.3: Main = struct_value () [template]
// CHECK:STDOUT:   %.2: type = tuple_type (type) [template]
// CHECK:STDOUT:   %.3: type = tuple_type (i32) [template]
// CHECK:STDOUT:   %.4: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %tuple: (i32,) = tuple_value (%.4) [template]
// CHECK:STDOUT:   %.5: i32 = int_literal 0 [template]
// CHECK:STDOUT:   %.6: i32 = int_literal 6 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Foo = %Foo.decl
// CHECK:STDOUT:     .Main = %Main.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.2: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %Foo.decl: Foo = fn_decl @Foo [template = constants.%struct.2] {
// CHECK:STDOUT:     %int.make_type_32.loc7_11: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc7_11.1: type = value_of_initializer %int.make_type_32.loc7_11 [template = i32]
// CHECK:STDOUT:     %.loc7_11.2: type = converted %int.make_type_32.loc7_11, %.loc7_11.1 [template = i32]
// CHECK:STDOUT:     %a.loc7_8.1: i32 = param a
// CHECK:STDOUT:     @Foo.%a: i32 = bind_name a, %a.loc7_8.1
// CHECK:STDOUT:     %int.make_type_32.loc7_19: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc7_19.1: type = value_of_initializer %int.make_type_32.loc7_19 [template = i32]
// CHECK:STDOUT:     %.loc7_19.2: type = converted %int.make_type_32.loc7_19, %.loc7_19.1 [template = i32]
// CHECK:STDOUT:     %b.loc7_16.1: i32 = param b
// CHECK:STDOUT:     @Foo.%b: i32 = bind_name b, %b.loc7_16.1
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Main.decl: Main = fn_decl @Main [template = constants.%struct.3] {}
// CHECK:STDOUT:   %import_ref.3: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Foo(%a: i32, %b: i32) {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Main() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %int.make_type_32: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %.loc10_15.1: (type,) = tuple_literal (%int.make_type_32)
// CHECK:STDOUT:   %.loc10_15.2: type = value_of_initializer %int.make_type_32 [template = i32]
// CHECK:STDOUT:   %.loc10_15.3: type = converted %int.make_type_32, %.loc10_15.2 [template = i32]
// CHECK:STDOUT:   %.loc10_15.4: type = converted %.loc10_15.1, constants.%.3 [template = constants.%.3]
// CHECK:STDOUT:   %x.var: ref (i32,) = var x
// CHECK:STDOUT:   %x: ref (i32,) = bind_name x, %x.var
// CHECK:STDOUT:   %.loc10_20: i32 = int_literal 1 [template = constants.%.4]
// CHECK:STDOUT:   %.loc10_22.1: (i32,) = tuple_literal (%.loc10_20)
// CHECK:STDOUT:   %.loc10_22.2: init (i32,) = tuple_init (%.loc10_20) to %x.var [template = constants.%tuple]
// CHECK:STDOUT:   %.loc10_23: init (i32,) = converted %.loc10_22.1, %.loc10_22.2 [template = constants.%tuple]
// CHECK:STDOUT:   assign %x.var, %.loc10_23
// CHECK:STDOUT:   %Foo.ref: Foo = name_ref Foo, file.%Foo.decl [template = constants.%struct.2]
// CHECK:STDOUT:   %x.ref: ref (i32,) = name_ref x, %x
// CHECK:STDOUT:   %.loc12_9: i32 = int_literal 0 [template = constants.%.5]
// CHECK:STDOUT:   %.loc12_10.1: ref i32 = tuple_index %x.ref, %.loc12_9
// CHECK:STDOUT:   %.loc12_13: i32 = int_literal 6 [template = constants.%.6]
// CHECK:STDOUT:   %.loc12_10.2: i32 = bind_value %.loc12_10.1
// CHECK:STDOUT:   %Foo.call: init () = call %Foo.ref(%.loc12_10.2, %.loc12_13)
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
