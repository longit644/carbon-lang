// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

fn F() {
  let T:! type = i32;
  var p: T*;
  var a: T = *p;
}

// CHECK:STDOUT: --- generic.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %F: type = fn_type @F [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: F = struct_value () [template]
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %struct.2: Int32 = struct_value () [template]
// CHECK:STDOUT:   %T: type = bind_symbolic_name T 0 [symbolic]
// CHECK:STDOUT:   %.2: type = ptr_type T [symbolic]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .F = %F.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %F.decl: F = fn_decl @F [template = constants.%struct.1] {}
// CHECK:STDOUT:   %import_ref: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.2]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %int.make_type_32: init type = call constants.%struct.2() [template = i32]
// CHECK:STDOUT:   %.loc8_21.1: type = value_of_initializer %int.make_type_32 [template = i32]
// CHECK:STDOUT:   %.loc8_21.2: type = converted %int.make_type_32, %.loc8_21.1 [template = i32]
// CHECK:STDOUT:   %T: type = bind_symbolic_name T 0, %.loc8_21.2 [symbolic = constants.%T]
// CHECK:STDOUT:   %T.ref.loc9: type = name_ref T, %T [symbolic = constants.%T]
// CHECK:STDOUT:   %.loc9: type = ptr_type T [symbolic = constants.%.2]
// CHECK:STDOUT:   %p.var: ref T* = var p
// CHECK:STDOUT:   %p: ref T* = bind_name p, %p.var
// CHECK:STDOUT:   %T.ref.loc10: type = name_ref T, %T [symbolic = constants.%T]
// CHECK:STDOUT:   %a.var: ref T = var a
// CHECK:STDOUT:   %a: ref T = bind_name a, %a.var
// CHECK:STDOUT:   %p.ref: ref T* = name_ref p, %p
// CHECK:STDOUT:   %.loc10_15: T* = bind_value %p.ref
// CHECK:STDOUT:   %.loc10_14.1: ref T = deref %.loc10_15
// CHECK:STDOUT:   %.loc10_14.2: T = bind_value %.loc10_14.1
// CHECK:STDOUT:   assign %a.var, %.loc10_14.2
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
