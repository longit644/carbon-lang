// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// CHECK:STDERR: fail_deref_type.carbon:[[@LINE+7]]:8: ERROR: Cannot dereference operand of non-pointer type `type`.
// CHECK:STDERR: var p: *i32;
// CHECK:STDERR:        ^
// CHECK:STDERR: fail_deref_type.carbon:[[@LINE+4]]:8: To form a pointer type, write the `*` after the pointee type.
// CHECK:STDERR: var p: *i32;
// CHECK:STDERR:        ^
// CHECK:STDERR:
var p: *i32;
// CHECK:STDERR: fail_deref_type.carbon:[[@LINE+3]]:12: ERROR: Cannot apply `->` operator to non-pointer type `type`.
// CHECK:STDERR: var p2: i32->foo;
// CHECK:STDERR:            ^~
var p2: i32->foo;

// CHECK:STDOUT: --- fail_deref_type.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct: Int32 = struct_value () [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .p = %p
// CHECK:STDOUT:     .p2 = %p2
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct]
// CHECK:STDOUT:   %int.make_type_32.loc14: init type = call constants.%struct() [template = i32]
// CHECK:STDOUT:   %.loc14_9.1: type = value_of_initializer %int.make_type_32.loc14 [template = i32]
// CHECK:STDOUT:   %.loc14_9.2: type = converted %int.make_type_32.loc14, %.loc14_9.1 [template = i32]
// CHECK:STDOUT:   %.loc14_8: ref <error> = deref %.loc14_9.2
// CHECK:STDOUT:   %p.var: ref <error> = var p
// CHECK:STDOUT:   %p: ref <error> = bind_name p, %p.var
// CHECK:STDOUT:   %import_ref.2: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct]
// CHECK:STDOUT:   %int.make_type_32.loc18: init type = call constants.%struct() [template = i32]
// CHECK:STDOUT:   %.loc18_9.1: type = value_of_initializer %int.make_type_32.loc18 [template = i32]
// CHECK:STDOUT:   %.loc18_9.2: type = converted %int.make_type_32.loc18, %.loc18_9.1 [template = i32]
// CHECK:STDOUT:   %.loc18_12: ref <error> = deref %.loc18_9.2
// CHECK:STDOUT:   %p2.var: ref <error> = var p2
// CHECK:STDOUT:   %p2: ref <error> = bind_name p2, %p2.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
