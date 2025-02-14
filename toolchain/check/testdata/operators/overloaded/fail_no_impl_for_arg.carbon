// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

package User;

class C {};
class D {};

impl C as Core.Add {
  fn Op[self: C](other: C) -> C;
}
impl C as Core.AddAssign {
  fn Op[addr self: C*](other: C);
}

fn Test(a: C, b: D) -> C {
  // CHECK:STDERR: fail_no_impl_for_arg.carbon:[[@LINE+7]]:10: ERROR: Cannot implicitly convert from `D` to `C`.
  // CHECK:STDERR:   return a + b;
  // CHECK:STDERR:          ^~~~~
  // CHECK:STDERR: fail_no_impl_for_arg.carbon:[[@LINE-10]]:3: Initializing parameter 1 of function declared here.
  // CHECK:STDERR:   fn Op[self: C](other: C) -> C;
  // CHECK:STDERR:   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // CHECK:STDERR:
  return a + b;
}

fn TestAssign(b: D) {
  var a: C = {};
  // CHECK:STDERR: fail_no_impl_for_arg.carbon:[[@LINE+6]]:3: ERROR: Cannot implicitly convert from `D` to `C`.
  // CHECK:STDERR:   a += b;
  // CHECK:STDERR:   ^~~~~~
  // CHECK:STDERR: fail_no_impl_for_arg.carbon:[[@LINE-19]]:3: Initializing parameter 1 of function declared here.
  // CHECK:STDERR:   fn Op[addr self: C*](other: C);
  // CHECK:STDERR:   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  a += b;
}

// CHECK:STDOUT: --- fail_no_impl_for_arg.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %C: type = class_type @C [template]
// CHECK:STDOUT:   %.1: type = struct_type {} [template]
// CHECK:STDOUT:   %D: type = class_type @D [template]
// CHECK:STDOUT:   %.2: type = interface_type @Add [template]
// CHECK:STDOUT:   %Self.1: Add = bind_symbolic_name Self 0 [symbolic]
// CHECK:STDOUT:   %Op.1: type = fn_type @Op.1 [template]
// CHECK:STDOUT:   %.3: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Op = struct_value () [template]
// CHECK:STDOUT:   %Op.2: type = fn_type @Op.2 [template]
// CHECK:STDOUT:   %struct.2: Op = struct_value () [template]
// CHECK:STDOUT:   %.4: <witness> = interface_witness (%struct.1) [template]
// CHECK:STDOUT:   %.5: type = interface_type @AddAssign [template]
// CHECK:STDOUT:   %Self.2: AddAssign = bind_symbolic_name Self 0 [symbolic]
// CHECK:STDOUT:   %.6: type = ptr_type C [template]
// CHECK:STDOUT:   %Op.3: type = fn_type @Op.3 [template]
// CHECK:STDOUT:   %struct.3: Op = struct_value () [template]
// CHECK:STDOUT:   %.7: type = ptr_type Self [symbolic]
// CHECK:STDOUT:   %Op.4: type = fn_type @Op.4 [template]
// CHECK:STDOUT:   %struct.4: Op = struct_value () [template]
// CHECK:STDOUT:   %.8: <witness> = interface_witness (%struct.3) [template]
// CHECK:STDOUT:   %Test: type = fn_type @Test [template]
// CHECK:STDOUT:   %struct.5: Test = struct_value () [template]
// CHECK:STDOUT:   %.9: type = ptr_type {} [template]
// CHECK:STDOUT:   %.10: type = assoc_entity_type @Add, Op [template]
// CHECK:STDOUT:   %.11: <associated Op in Add> = assoc_entity element0, file.%import_ref.10 [template]
// CHECK:STDOUT:   %TestAssign: type = fn_type @TestAssign [template]
// CHECK:STDOUT:   %struct.6: TestAssign = struct_value () [template]
// CHECK:STDOUT:   %struct.7: C = struct_value () [template]
// CHECK:STDOUT:   %.12: type = assoc_entity_type @AddAssign, Op [template]
// CHECK:STDOUT:   %.13: <associated Op in AddAssign> = assoc_entity element0, file.%import_ref.12 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .C = %C.decl
// CHECK:STDOUT:     .D = %D.decl
// CHECK:STDOUT:     .Test = %Test.decl
// CHECK:STDOUT:     .TestAssign = %TestAssign.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %C.decl: type = class_decl @C [template = constants.%C] {}
// CHECK:STDOUT:   %D.decl: type = class_decl @D [template = constants.%D] {}
// CHECK:STDOUT:   %import_ref.1: type = import_ref ir4, inst+1, loaded [template = constants.%.2]
// CHECK:STDOUT:   %import_ref.2 = import_ref ir4, inst+3, unloaded
// CHECK:STDOUT:   %import_ref.3: <associated Op in Add> = import_ref ir4, inst+24, loaded [template = constants.%.11]
// CHECK:STDOUT:   %import_ref.4: Op = import_ref ir4, inst+19, loaded [template = constants.%struct.2]
// CHECK:STDOUT:   impl_decl @impl.1 {
// CHECK:STDOUT:     %C.ref.loc12: type = name_ref C, %C.decl [template = constants.%C]
// CHECK:STDOUT:     %Core.ref.loc12: <namespace> = name_ref Core, %Core [template = %Core]
// CHECK:STDOUT:     %Add.ref: type = name_ref Add, %import_ref.1 [template = constants.%.2]
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.5: type = import_ref ir4, inst+26, loaded [template = constants.%.5]
// CHECK:STDOUT:   %import_ref.6 = import_ref ir4, inst+28, unloaded
// CHECK:STDOUT:   %import_ref.7: <associated Op in AddAssign> = import_ref ir4, inst+47, loaded [template = constants.%.13]
// CHECK:STDOUT:   %import_ref.8: Op = import_ref ir4, inst+43, loaded [template = constants.%struct.4]
// CHECK:STDOUT:   impl_decl @impl.2 {
// CHECK:STDOUT:     %C.ref.loc15: type = name_ref C, %C.decl [template = constants.%C]
// CHECK:STDOUT:     %Core.ref.loc15: <namespace> = name_ref Core, %Core [template = %Core]
// CHECK:STDOUT:     %AddAssign.ref: type = name_ref AddAssign, %import_ref.5 [template = constants.%.5]
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Test.decl: Test = fn_decl @Test [template = constants.%struct.5] {
// CHECK:STDOUT:     %C.ref.loc19_12: type = name_ref C, %C.decl [template = constants.%C]
// CHECK:STDOUT:     %a.loc19_9.1: C = param a
// CHECK:STDOUT:     @Test.%a: C = bind_name a, %a.loc19_9.1
// CHECK:STDOUT:     %D.ref.loc19: type = name_ref D, %D.decl [template = constants.%D]
// CHECK:STDOUT:     %b.loc19_15.1: D = param b
// CHECK:STDOUT:     @Test.%b: D = bind_name b, %b.loc19_15.1
// CHECK:STDOUT:     %C.ref.loc19_24: type = name_ref C, %C.decl [template = constants.%C]
// CHECK:STDOUT:     @Test.%return: ref C = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.9: type = import_ref ir4, inst+1, loaded [template = constants.%.2]
// CHECK:STDOUT:   %import_ref.10 = import_ref ir4, inst+19, unloaded
// CHECK:STDOUT:   %TestAssign.decl: TestAssign = fn_decl @TestAssign [template = constants.%struct.6] {
// CHECK:STDOUT:     %D.ref.loc30: type = name_ref D, %D.decl [template = constants.%D]
// CHECK:STDOUT:     %b.loc30_15.1: D = param b
// CHECK:STDOUT:     @TestAssign.%b: D = bind_name b, %b.loc30_15.1
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.11: type = import_ref ir4, inst+26, loaded [template = constants.%.5]
// CHECK:STDOUT:   %import_ref.12 = import_ref ir4, inst+43, unloaded
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: interface @Add {
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
// CHECK:STDOUT: impl @impl.1: C as Add {
// CHECK:STDOUT:   %Op.decl: Op = fn_decl @Op.1 [template = constants.%struct.1] {
// CHECK:STDOUT:     %C.ref.loc13_15: type = name_ref C, file.%C.decl [template = constants.%C]
// CHECK:STDOUT:     %self.loc13_9.1: C = param self
// CHECK:STDOUT:     %self.loc13_9.2: C = bind_name self, %self.loc13_9.1
// CHECK:STDOUT:     %C.ref.loc13_25: type = name_ref C, file.%C.decl [template = constants.%C]
// CHECK:STDOUT:     %other.loc13_18.1: C = param other
// CHECK:STDOUT:     %other.loc13_18.2: C = bind_name other, %other.loc13_18.1
// CHECK:STDOUT:     %C.ref.loc13_31: type = name_ref C, file.%C.decl [template = constants.%C]
// CHECK:STDOUT:     %return.var: ref C = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %.1: <witness> = interface_witness (%Op.decl) [template = constants.%.4]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Op = %Op.decl
// CHECK:STDOUT:   witness = %.1
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: impl @impl.2: C as AddAssign {
// CHECK:STDOUT:   %Op.decl: Op = fn_decl @Op.3 [template = constants.%struct.3] {
// CHECK:STDOUT:     %C.ref.loc16_20: type = name_ref C, file.%C.decl [template = constants.%C]
// CHECK:STDOUT:     %.loc16_21: type = ptr_type C [template = constants.%.6]
// CHECK:STDOUT:     %self.loc16_14.1: C* = param self
// CHECK:STDOUT:     %self.loc16_14.3: C* = bind_name self, %self.loc16_14.1
// CHECK:STDOUT:     %.loc16_9: C* = addr_pattern %self.loc16_14.3
// CHECK:STDOUT:     %C.ref.loc16_31: type = name_ref C, file.%C.decl [template = constants.%C]
// CHECK:STDOUT:     %other.loc16_24.1: C = param other
// CHECK:STDOUT:     %other.loc16_24.2: C = bind_name other, %other.loc16_24.1
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %.1: <witness> = interface_witness (%Op.decl) [template = constants.%.8]
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
// CHECK:STDOUT: class @D {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%D
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Op.1[@impl.1.%self.loc13_9.2: C](@impl.1.%other.loc13_18.2: C) -> C;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Op.2[%self: Self](%other: Self) -> Self;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Op.3[addr @impl.2.%self.loc16_14.3: C*](@impl.2.%other.loc16_24.2: C);
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Op.4[addr %self: Self*](%other: Self);
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Test(%a: C, %b: D) -> %return: C {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %a.ref: C = name_ref a, %a
// CHECK:STDOUT:   %b.ref: D = name_ref b, %b
// CHECK:STDOUT:   %.1: Op = interface_witness_access @impl.1.%.1, element0 [template = constants.%struct.1]
// CHECK:STDOUT:   %.loc27_12.1: <bound method> = bound_method %a.ref, %.1
// CHECK:STDOUT:   %.loc27_12.2: ref C = temporary_storage
// CHECK:STDOUT:   %Op.call: init C = call %.loc27_12.1(<invalid>) [template = <error>]
// CHECK:STDOUT:   return %Op.call to %return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @TestAssign(%b: D) {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %C.ref: type = name_ref C, file.%C.decl [template = constants.%C]
// CHECK:STDOUT:   %a.var: ref C = var a
// CHECK:STDOUT:   %a: ref C = bind_name a, %a.var
// CHECK:STDOUT:   %.loc31_15.1: {} = struct_literal ()
// CHECK:STDOUT:   %.loc31_15.2: init C = class_init (), %a.var [template = constants.%struct.7]
// CHECK:STDOUT:   %.loc31_16: init C = converted %.loc31_15.1, %.loc31_15.2 [template = constants.%struct.7]
// CHECK:STDOUT:   assign %a.var, %.loc31_16
// CHECK:STDOUT:   %a.ref: ref C = name_ref a, %a
// CHECK:STDOUT:   %b.ref: D = name_ref b, %b
// CHECK:STDOUT:   %.1: Op = interface_witness_access @impl.2.%.1, element0 [template = constants.%struct.3]
// CHECK:STDOUT:   %.loc38_5: <bound method> = bound_method %a.ref, %.1
// CHECK:STDOUT:   %.loc38_3: C* = addr_of %a.ref
// CHECK:STDOUT:   %Op.call: init () = call %.loc38_5(<invalid>) [template = <error>]
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
