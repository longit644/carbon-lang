// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

package User;

class C {};

impl C as Core.Inc {
  fn Op[addr self: C*]();
}
impl C as Core.AddAssign {
  fn Op[addr self: C*](other: C);
}

fn TestIncNonRef(a: C) {
  // CHECK:STDERR: fail_assign_non_ref.carbon:[[@LINE+7]]:3: ERROR: `addr self` method cannot be invoked on a value.
  // CHECK:STDERR:   ++a;
  // CHECK:STDERR:   ^~
  // CHECK:STDERR: fail_assign_non_ref.carbon:[[@LINE-10]]:14: Initializing `addr self` parameter of method declared here.
  // CHECK:STDERR:   fn Op[addr self: C*]();
  // CHECK:STDERR:              ^~~~
  // CHECK:STDERR:
  ++a;
}

fn TestAddAssignNonRef(a: C, b: C) {
  // CHECK:STDERR: fail_assign_non_ref.carbon:[[@LINE+6]]:5: ERROR: `addr self` method cannot be invoked on a value.
  // CHECK:STDERR:   a += b;
  // CHECK:STDERR:     ^~
  // CHECK:STDERR: fail_assign_non_ref.carbon:[[@LINE-18]]:14: Initializing `addr self` parameter of method declared here.
  // CHECK:STDERR:   fn Op[addr self: C*](other: C);
  // CHECK:STDERR:              ^~~~
  a += b;
}

// CHECK:STDOUT: --- fail_assign_non_ref.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %C: type = class_type @C [template]
// CHECK:STDOUT:   %.1: type = struct_type {} [template]
// CHECK:STDOUT:   %.2: type = interface_type @Inc [template]
// CHECK:STDOUT:   %Self.1: Inc = bind_symbolic_name Self 0 [symbolic]
// CHECK:STDOUT:   %.3: type = ptr_type C [template]
// CHECK:STDOUT:   %Op.1: type = fn_type @Op.1 [template]
// CHECK:STDOUT:   %.4: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Op = struct_value () [template]
// CHECK:STDOUT:   %.5: type = ptr_type Self [symbolic]
// CHECK:STDOUT:   %Op.2: type = fn_type @Op.2 [template]
// CHECK:STDOUT:   %struct.2: Op = struct_value () [template]
// CHECK:STDOUT:   %.6: <witness> = interface_witness (%struct.1) [template]
// CHECK:STDOUT:   %.7: type = interface_type @AddAssign [template]
// CHECK:STDOUT:   %Self.2: AddAssign = bind_symbolic_name Self 0 [symbolic]
// CHECK:STDOUT:   %Op.3: type = fn_type @Op.3 [template]
// CHECK:STDOUT:   %struct.3: Op = struct_value () [template]
// CHECK:STDOUT:   %.8: type = ptr_type Self [symbolic]
// CHECK:STDOUT:   %Op.4: type = fn_type @Op.4 [template]
// CHECK:STDOUT:   %struct.4: Op = struct_value () [template]
// CHECK:STDOUT:   %.9: <witness> = interface_witness (%struct.3) [template]
// CHECK:STDOUT:   %TestIncNonRef: type = fn_type @TestIncNonRef [template]
// CHECK:STDOUT:   %struct.5: TestIncNonRef = struct_value () [template]
// CHECK:STDOUT:   %.10: type = ptr_type {} [template]
// CHECK:STDOUT:   %.11: type = assoc_entity_type @Inc, Op [template]
// CHECK:STDOUT:   %.12: <associated Op in Inc> = assoc_entity element0, file.%import_ref.10 [template]
// CHECK:STDOUT:   %TestAddAssignNonRef: type = fn_type @TestAddAssignNonRef [template]
// CHECK:STDOUT:   %struct.6: TestAddAssignNonRef = struct_value () [template]
// CHECK:STDOUT:   %.13: type = assoc_entity_type @AddAssign, Op [template]
// CHECK:STDOUT:   %.14: <associated Op in AddAssign> = assoc_entity element0, file.%import_ref.12 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .C = %C.decl
// CHECK:STDOUT:     .TestIncNonRef = %TestIncNonRef.decl
// CHECK:STDOUT:     .TestAddAssignNonRef = %TestAddAssignNonRef.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %C.decl: type = class_decl @C [template = constants.%C] {}
// CHECK:STDOUT:   %import_ref.1: type = import_ref ir4, inst+49, loaded [template = constants.%.2]
// CHECK:STDOUT:   %import_ref.2 = import_ref ir4, inst+51, unloaded
// CHECK:STDOUT:   %import_ref.3: <associated Op in Inc> = import_ref ir4, inst+65, loaded [template = constants.%.12]
// CHECK:STDOUT:   %import_ref.4: Op = import_ref ir4, inst+61, loaded [template = constants.%struct.2]
// CHECK:STDOUT:   impl_decl @impl.1 {
// CHECK:STDOUT:     %C.ref.loc11: type = name_ref C, %C.decl [template = constants.%C]
// CHECK:STDOUT:     %Core.ref.loc11: <namespace> = name_ref Core, %Core [template = %Core]
// CHECK:STDOUT:     %Inc.ref: type = name_ref Inc, %import_ref.1 [template = constants.%.2]
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.5: type = import_ref ir4, inst+26, loaded [template = constants.%.7]
// CHECK:STDOUT:   %import_ref.6 = import_ref ir4, inst+28, unloaded
// CHECK:STDOUT:   %import_ref.7: <associated Op in AddAssign> = import_ref ir4, inst+47, loaded [template = constants.%.14]
// CHECK:STDOUT:   %import_ref.8: Op = import_ref ir4, inst+43, loaded [template = constants.%struct.4]
// CHECK:STDOUT:   impl_decl @impl.2 {
// CHECK:STDOUT:     %C.ref.loc14: type = name_ref C, %C.decl [template = constants.%C]
// CHECK:STDOUT:     %Core.ref.loc14: <namespace> = name_ref Core, %Core [template = %Core]
// CHECK:STDOUT:     %AddAssign.ref: type = name_ref AddAssign, %import_ref.5 [template = constants.%.7]
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %TestIncNonRef.decl: TestIncNonRef = fn_decl @TestIncNonRef [template = constants.%struct.5] {
// CHECK:STDOUT:     %C.ref.loc18: type = name_ref C, %C.decl [template = constants.%C]
// CHECK:STDOUT:     %a.loc18_18.1: C = param a
// CHECK:STDOUT:     @TestIncNonRef.%a: C = bind_name a, %a.loc18_18.1
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.9: type = import_ref ir4, inst+49, loaded [template = constants.%.2]
// CHECK:STDOUT:   %import_ref.10 = import_ref ir4, inst+61, unloaded
// CHECK:STDOUT:   %TestAddAssignNonRef.decl: TestAddAssignNonRef = fn_decl @TestAddAssignNonRef [template = constants.%struct.6] {
// CHECK:STDOUT:     %C.ref.loc29_27: type = name_ref C, %C.decl [template = constants.%C]
// CHECK:STDOUT:     %a.loc29_24.1: C = param a
// CHECK:STDOUT:     @TestAddAssignNonRef.%a: C = bind_name a, %a.loc29_24.1
// CHECK:STDOUT:     %C.ref.loc29_33: type = name_ref C, %C.decl [template = constants.%C]
// CHECK:STDOUT:     %b.loc29_30.1: C = param b
// CHECK:STDOUT:     @TestAddAssignNonRef.%b: C = bind_name b, %b.loc29_30.1
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.11: type = import_ref ir4, inst+26, loaded [template = constants.%.7]
// CHECK:STDOUT:   %import_ref.12 = import_ref ir4, inst+43, unloaded
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: interface @Inc {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = file.%import_ref.2
// CHECK:STDOUT:   .Op = file.%import_ref.3
// CHECK:STDOUT:   witness = (file.%import_ref.4)
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: interface @AddAssign {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = file.%import_ref.6
// CHECK:STDOUT:   .Op = file.%import_ref.7
// CHECK:STDOUT:   witness = (file.%import_ref.8)
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: impl @impl.1: C as Inc {
// CHECK:STDOUT:   %Op.decl: Op = fn_decl @Op.1 [template = constants.%struct.1] {
// CHECK:STDOUT:     %C.ref: type = name_ref C, file.%C.decl [template = constants.%C]
// CHECK:STDOUT:     %.loc12_21: type = ptr_type C [template = constants.%.3]
// CHECK:STDOUT:     %self.loc12_14.1: C* = param self
// CHECK:STDOUT:     %self.loc12_14.3: C* = bind_name self, %self.loc12_14.1
// CHECK:STDOUT:     %.loc12_9: C* = addr_pattern %self.loc12_14.3
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %.1: <witness> = interface_witness (%Op.decl) [template = constants.%.6]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Op = %Op.decl
// CHECK:STDOUT:   witness = %.1
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: impl @impl.2: C as AddAssign {
// CHECK:STDOUT:   %Op.decl: Op = fn_decl @Op.3 [template = constants.%struct.3] {
// CHECK:STDOUT:     %C.ref.loc15_20: type = name_ref C, file.%C.decl [template = constants.%C]
// CHECK:STDOUT:     %.loc15_21: type = ptr_type C [template = constants.%.3]
// CHECK:STDOUT:     %self.loc15_14.1: C* = param self
// CHECK:STDOUT:     %self.loc15_14.3: C* = bind_name self, %self.loc15_14.1
// CHECK:STDOUT:     %.loc15_9: C* = addr_pattern %self.loc15_14.3
// CHECK:STDOUT:     %C.ref.loc15_31: type = name_ref C, file.%C.decl [template = constants.%C]
// CHECK:STDOUT:     %other.loc15_24.1: C = param other
// CHECK:STDOUT:     %other.loc15_24.2: C = bind_name other, %other.loc15_24.1
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %.1: <witness> = interface_witness (%Op.decl) [template = constants.%.9]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Op = %Op.decl
// CHECK:STDOUT:   witness = %.1
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @C {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%C
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Op.1[addr @impl.1.%self.loc12_14.3: C*]();
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Op.2[addr %self: Self*]();
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Op.3[addr @impl.2.%self.loc15_14.3: C*](@impl.2.%other.loc15_24.2: C);
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Op.4[addr %self: Self*](%other: Self);
// CHECK:STDOUT:
// CHECK:STDOUT: fn @TestIncNonRef(%a: C) {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %a.ref: C = name_ref a, %a
// CHECK:STDOUT:   %.1: Op = interface_witness_access @impl.1.%.1, element0 [template = constants.%struct.1]
// CHECK:STDOUT:   %.loc26: <bound method> = bound_method %a.ref, %.1
// CHECK:STDOUT:   %Op.call: init () = call %.loc26(<invalid>) [template = <error>]
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @TestAddAssignNonRef(%a: C, %b: C) {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %a.ref: C = name_ref a, %a
// CHECK:STDOUT:   %b.ref: C = name_ref b, %b
// CHECK:STDOUT:   %.1: Op = interface_witness_access @impl.2.%.1, element0 [template = constants.%struct.3]
// CHECK:STDOUT:   %.loc36: <bound method> = bound_method %a.ref, %.1
// CHECK:STDOUT:   %Op.call: init () = call %.loc36(<invalid>) [template = <error>]
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
