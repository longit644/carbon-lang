// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// TODO: The `const` in the return type should not be necessary.
fn F(p: const (const (const i32*)*)) -> const i32 {
  return **p;
}

// CHECK:STDOUT: --- nested_const.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Int32 = struct_value () [template]
// CHECK:STDOUT:   %.2: type = const_type i32 [template]
// CHECK:STDOUT:   %.3: type = ptr_type const i32 [template]
// CHECK:STDOUT:   %.4: type = const_type const i32* [template]
// CHECK:STDOUT:   %.5: type = ptr_type const (const i32*) [template]
// CHECK:STDOUT:   %.6: type = const_type const (const i32*)* [template]
// CHECK:STDOUT:   %F: type = fn_type @F [template]
// CHECK:STDOUT:   %struct.2: F = struct_value () [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .F = %F.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.2: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %F.decl: F = fn_decl @F [template = constants.%struct.2] {
// CHECK:STDOUT:     %int.make_type_32.loc8_29: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc8_23.1: type = value_of_initializer %int.make_type_32.loc8_29 [template = i32]
// CHECK:STDOUT:     %.loc8_23.2: type = converted %int.make_type_32.loc8_29, %.loc8_23.1 [template = i32]
// CHECK:STDOUT:     %.loc8_23.3: type = const_type i32 [template = constants.%.2]
// CHECK:STDOUT:     %.loc8_32: type = ptr_type const i32 [template = constants.%.3]
// CHECK:STDOUT:     %.loc8_16: type = const_type const i32* [template = constants.%.4]
// CHECK:STDOUT:     %.loc8_34: type = ptr_type const (const i32*) [template = constants.%.5]
// CHECK:STDOUT:     %.loc8_9: type = const_type const (const i32*)* [template = constants.%.6]
// CHECK:STDOUT:     %p.loc8_6.1: const (const (const i32*)*) = param p
// CHECK:STDOUT:     @F.%p: const (const (const i32*)*) = bind_name p, %p.loc8_6.1
// CHECK:STDOUT:     %int.make_type_32.loc8_47: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc8_41.1: type = value_of_initializer %int.make_type_32.loc8_47 [template = i32]
// CHECK:STDOUT:     %.loc8_41.2: type = converted %int.make_type_32.loc8_47, %.loc8_41.1 [template = i32]
// CHECK:STDOUT:     %.loc8_41.3: type = const_type i32 [template = constants.%.2]
// CHECK:STDOUT:     @F.%return: ref const i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F(%p: const (const (const i32*)*)) -> const i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %p.ref: const (const (const i32*)*) = name_ref p, %p
// CHECK:STDOUT:   %.loc9_11.1: ref const (const i32*) = deref %p.ref
// CHECK:STDOUT:   %.loc9_11.2: const (const i32*) = bind_value %.loc9_11.1
// CHECK:STDOUT:   %.loc9_10.1: ref const i32 = deref %.loc9_11.2
// CHECK:STDOUT:   %.loc9_10.2: const i32 = bind_value %.loc9_10.1
// CHECK:STDOUT:   return %.loc9_10.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
