// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

class Incomplete;

// CHECK:STDERR: fail_nested_incomplete.carbon:[[@LINE+6]]:8: ERROR: Variable has incomplete type `(i32, Incomplete)`.
// CHECK:STDERR: var t: (i32, Incomplete);
// CHECK:STDERR:        ^~~~~~~~~~~~~~~~~
// CHECK:STDERR: fail_nested_incomplete.carbon:[[@LINE-5]]:1: Class was forward declared here.
// CHECK:STDERR: class Incomplete;
// CHECK:STDERR: ^~~~~~~~~~~~~~~~~
var t: (i32, Incomplete);

var p: Incomplete* = &t[1];

// CHECK:STDOUT: --- fail_nested_incomplete.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Incomplete: type = class_type @Incomplete [template]
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct: Int32 = struct_value () [template]
// CHECK:STDOUT:   %.2: type = tuple_type (type, type) [template]
// CHECK:STDOUT:   %.3: type = tuple_type (i32, Incomplete) [template]
// CHECK:STDOUT:   %.4: type = ptr_type Incomplete [template]
// CHECK:STDOUT:   %.5: i32 = int_literal 1 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Incomplete = %Incomplete.decl
// CHECK:STDOUT:     .t = %t
// CHECK:STDOUT:     .p = %p
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %Incomplete.decl: type = class_decl @Incomplete [template = constants.%Incomplete] {}
// CHECK:STDOUT:   %import_ref: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct]
// CHECK:STDOUT:   %int.make_type_32: init type = call constants.%struct() [template = i32]
// CHECK:STDOUT:   %Incomplete.ref.loc15: type = name_ref Incomplete, %Incomplete.decl [template = constants.%Incomplete]
// CHECK:STDOUT:   %.loc15_24.1: (type, type) = tuple_literal (%int.make_type_32, %Incomplete.ref.loc15)
// CHECK:STDOUT:   %.loc15_24.2: type = value_of_initializer %int.make_type_32 [template = i32]
// CHECK:STDOUT:   %.loc15_24.3: type = converted %int.make_type_32, %.loc15_24.2 [template = i32]
// CHECK:STDOUT:   %.loc15_24.4: type = converted %.loc15_24.1, constants.%.3 [template = constants.%.3]
// CHECK:STDOUT:   %t.var: ref <error> = var t
// CHECK:STDOUT:   %t: ref <error> = bind_name t, %t.var
// CHECK:STDOUT:   %Incomplete.ref.loc17: type = name_ref Incomplete, %Incomplete.decl [template = constants.%Incomplete]
// CHECK:STDOUT:   %.loc17: type = ptr_type Incomplete [template = constants.%.4]
// CHECK:STDOUT:   %p.var: ref Incomplete* = var p
// CHECK:STDOUT:   %p: ref Incomplete* = bind_name p, %p.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @Incomplete;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @__global_init() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %t.ref: ref <error> = name_ref t, file.%t
// CHECK:STDOUT:   %.loc17_25: i32 = int_literal 1 [template = constants.%.5]
// CHECK:STDOUT:   %.loc17_22: <error> = addr_of <error> [template = <error>]
// CHECK:STDOUT:   assign file.%p.var, <error>
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
