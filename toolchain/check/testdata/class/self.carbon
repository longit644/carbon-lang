// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

class Class {
  fn F[self: Self]() -> i32;
  fn G[addr self: Self*]() -> i32;

  var n: i32;
}

fn Class.F[self: Self]() -> i32 {
  return self.n;
}

fn Class.G[addr self: Self*]() -> i32 {
  return (*self).n;
}

// CHECK:STDOUT: --- self.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Class: type = class_type @Class [template]
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Int32 = struct_value () [template]
// CHECK:STDOUT:   %F: type = fn_type @F [template]
// CHECK:STDOUT:   %struct.2: F = struct_value () [template]
// CHECK:STDOUT:   %.2: type = ptr_type Class [template]
// CHECK:STDOUT:   %G: type = fn_type @G [template]
// CHECK:STDOUT:   %struct.3: G = struct_value () [template]
// CHECK:STDOUT:   %.3: type = unbound_element_type Class, i32 [template]
// CHECK:STDOUT:   %.4: type = struct_type {.n: i32} [template]
// CHECK:STDOUT:   %.5: type = ptr_type {.n: i32} [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Class = %Class.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %Class.decl: type = class_decl @Class [template = constants.%Class] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.2: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.3: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %import_ref.4: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %F.decl: F = fn_decl @F [template = constants.%struct.2] {
// CHECK:STDOUT:     %Self.ref.loc14: type = name_ref Self, constants.%Class [template = constants.%Class]
// CHECK:STDOUT:     %self.loc14_12.1: Class = param self
// CHECK:STDOUT:     @F.%self: Class = bind_name self, %self.loc14_12.1
// CHECK:STDOUT:     %int.make_type_32.loc14: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc14_29.1: type = value_of_initializer %int.make_type_32.loc14 [template = i32]
// CHECK:STDOUT:     %.loc14_29.2: type = converted %int.make_type_32.loc14, %.loc14_29.1 [template = i32]
// CHECK:STDOUT:     @F.%return: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.5: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct.1]
// CHECK:STDOUT:   %G.decl: G = fn_decl @G [template = constants.%struct.3] {
// CHECK:STDOUT:     %Self.ref.loc18: type = name_ref Self, constants.%Class [template = constants.%Class]
// CHECK:STDOUT:     %.loc18_27: type = ptr_type Class [template = constants.%.2]
// CHECK:STDOUT:     %self.loc18_17.1: Class* = param self
// CHECK:STDOUT:     @G.%self: Class* = bind_name self, %self.loc18_17.1
// CHECK:STDOUT:     @G.%.loc18: Class* = addr_pattern @G.%self
// CHECK:STDOUT:     %int.make_type_32.loc18: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc18_35.1: type = value_of_initializer %int.make_type_32.loc18 [template = i32]
// CHECK:STDOUT:     %.loc18_35.2: type = converted %int.make_type_32.loc18, %.loc18_35.1 [template = i32]
// CHECK:STDOUT:     @G.%return: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @Class {
// CHECK:STDOUT:   %F.decl: F = fn_decl @F [template = constants.%struct.2] {
// CHECK:STDOUT:     %Self.ref.loc8: type = name_ref Self, constants.%Class [template = constants.%Class]
// CHECK:STDOUT:     %self.loc8_8.1: Class = param self
// CHECK:STDOUT:     %self.loc8_8.2: Class = bind_name self, %self.loc8_8.1
// CHECK:STDOUT:     %int.make_type_32.loc8: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc8_25.1: type = value_of_initializer %int.make_type_32.loc8 [template = i32]
// CHECK:STDOUT:     %.loc8_25.2: type = converted %int.make_type_32.loc8, %.loc8_25.1 [template = i32]
// CHECK:STDOUT:     %return.var.loc8: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %G.decl: G = fn_decl @G [template = constants.%struct.3] {
// CHECK:STDOUT:     %Self.ref.loc9: type = name_ref Self, constants.%Class [template = constants.%Class]
// CHECK:STDOUT:     %.loc9_23: type = ptr_type Class [template = constants.%.2]
// CHECK:STDOUT:     %self.loc9_13.1: Class* = param self
// CHECK:STDOUT:     %self.loc9_13.3: Class* = bind_name self, %self.loc9_13.1
// CHECK:STDOUT:     %.loc9_8: Class* = addr_pattern %self.loc9_13.3
// CHECK:STDOUT:     %int.make_type_32.loc9: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:     %.loc9_31.1: type = value_of_initializer %int.make_type_32.loc9 [template = i32]
// CHECK:STDOUT:     %.loc9_31.2: type = converted %int.make_type_32.loc9, %.loc9_31.1 [template = i32]
// CHECK:STDOUT:     %return.var.loc9: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %int.make_type_32.loc11: init type = call constants.%struct.1() [template = i32]
// CHECK:STDOUT:   %.loc11_10.1: type = value_of_initializer %int.make_type_32.loc11 [template = i32]
// CHECK:STDOUT:   %.loc11_10.2: type = converted %int.make_type_32.loc11, %.loc11_10.1 [template = i32]
// CHECK:STDOUT:   %.loc11_8: <unbound element of class Class> = field_decl n, element0 [template]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%Class
// CHECK:STDOUT:   .F = %F.decl
// CHECK:STDOUT:   .G = %G.decl
// CHECK:STDOUT:   .n = %.loc11_8
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F[%self: Class]() -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %self.ref: Class = name_ref self, %self
// CHECK:STDOUT:   %n.ref: <unbound element of class Class> = name_ref n, @Class.%.loc11_8 [template = @Class.%.loc11_8]
// CHECK:STDOUT:   %.loc15_14.1: ref i32 = class_element_access %self.ref, element0
// CHECK:STDOUT:   %.loc15_14.2: i32 = bind_value %.loc15_14.1
// CHECK:STDOUT:   return %.loc15_14.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @G[addr %self: Class*]() -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %self.ref: Class* = name_ref self, %self
// CHECK:STDOUT:   %.loc19_11: ref Class = deref %self.ref
// CHECK:STDOUT:   %n.ref: <unbound element of class Class> = name_ref n, @Class.%.loc11_8 [template = @Class.%.loc11_8]
// CHECK:STDOUT:   %.loc19_17.1: ref i32 = class_element_access %.loc19_11, element0
// CHECK:STDOUT:   %.loc19_17.2: i32 = bind_value %.loc19_17.1
// CHECK:STDOUT:   return %.loc19_17.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
