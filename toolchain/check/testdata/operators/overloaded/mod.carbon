// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// This file was generated from binary_op.carbon.tmpl. Run make_tests.sh to regenerate.

package User;

class C {};

impl C as Core.Mod {
  fn Op[self: C](other: C) -> C {
    return {};
  }
}
impl C as Core.ModAssign {
  fn Op[addr self: C*](other: C) {}
}

fn TestOp(a: C, b: C) -> C {
  return a % b;
}

fn TestAssign(a: C*, b: C) {
  *a %= b;
}

// CHECK:STDOUT: --- mod.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %C: type = class_type @C [template]
// CHECK:STDOUT:   %.1: type = struct_type {} [template]
// CHECK:STDOUT:   %.2: type = interface_type @Mod [template]
// CHECK:STDOUT:   %Self.1: Mod = bind_symbolic_name Self 0 [symbolic]
// CHECK:STDOUT:   %Op.1: type = fn_type @Op.1 [template]
// CHECK:STDOUT:   %.3: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Op = struct_value () [template]
// CHECK:STDOUT:   %Op.2: type = fn_type @Op.2 [template]
// CHECK:STDOUT:   %struct.2: Op = struct_value () [template]
// CHECK:STDOUT:   %.4: <witness> = interface_witness (%struct.1) [template]
// CHECK:STDOUT:   %.5: type = ptr_type {} [template]
// CHECK:STDOUT:   %struct.3: C = struct_value () [template]
// CHECK:STDOUT:   %.6: type = interface_type @ModAssign [template]
// CHECK:STDOUT:   %Self.2: ModAssign = bind_symbolic_name Self 0 [symbolic]
// CHECK:STDOUT:   %.7: type = ptr_type C [template]
// CHECK:STDOUT:   %Op.3: type = fn_type @Op.3 [template]
// CHECK:STDOUT:   %struct.4: Op = struct_value () [template]
// CHECK:STDOUT:   %.8: type = ptr_type Self [symbolic]
// CHECK:STDOUT:   %Op.4: type = fn_type @Op.4 [template]
// CHECK:STDOUT:   %struct.5: Op = struct_value () [template]
// CHECK:STDOUT:   %.9: <witness> = interface_witness (%struct.4) [template]
// CHECK:STDOUT:   %TestOp: type = fn_type @TestOp [template]
// CHECK:STDOUT:   %struct.6: TestOp = struct_value () [template]
// CHECK:STDOUT:   %.10: type = assoc_entity_type @Mod, Op [template]
// CHECK:STDOUT:   %.11: <associated Op in Mod> = assoc_entity element0, file.%import_ref.10 [template]
// CHECK:STDOUT:   %TestAssign: type = fn_type @TestAssign [template]
// CHECK:STDOUT:   %struct.7: TestAssign = struct_value () [template]
// CHECK:STDOUT:   %.12: type = assoc_entity_type @ModAssign, Op [template]
// CHECK:STDOUT:   %.13: <associated Op in ModAssign> = assoc_entity element0, file.%import_ref.12 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .C = %C.decl
// CHECK:STDOUT:     .TestOp = %TestOp.decl
// CHECK:STDOUT:     .TestAssign = %TestAssign.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %C.decl: type = class_decl @C [template = constants.%C] {}
// CHECK:STDOUT:   %import_ref.1: type = import_ref ir4, inst+245, loaded [template = constants.%.2]
// CHECK:STDOUT:   %import_ref.2 = import_ref ir4, inst+247, unloaded
// CHECK:STDOUT:   %import_ref.3: <associated Op in Mod> = import_ref ir4, inst+267, loaded [template = constants.%.11]
// CHECK:STDOUT:   %import_ref.4: Op = import_ref ir4, inst+263, loaded [template = constants.%struct.2]
// CHECK:STDOUT:   impl_decl @impl.1 {
// CHECK:STDOUT:     %C.ref.loc13: type = name_ref C, %C.decl [template = constants.%C]
// CHECK:STDOUT:     %Core.ref.loc13: <namespace> = name_ref Core, %Core [template = %Core]
// CHECK:STDOUT:     %Mod.ref: type = name_ref Mod, %import_ref.1 [template = constants.%.2]
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.5: type = import_ref ir4, inst+269, loaded [template = constants.%.6]
// CHECK:STDOUT:   %import_ref.6 = import_ref ir4, inst+271, unloaded
// CHECK:STDOUT:   %import_ref.7: <associated Op in ModAssign> = import_ref ir4, inst+290, loaded [template = constants.%.13]
// CHECK:STDOUT:   %import_ref.8: Op = import_ref ir4, inst+286, loaded [template = constants.%struct.5]
// CHECK:STDOUT:   impl_decl @impl.2 {
// CHECK:STDOUT:     %C.ref.loc18: type = name_ref C, %C.decl [template = constants.%C]
// CHECK:STDOUT:     %Core.ref.loc18: <namespace> = name_ref Core, %Core [template = %Core]
// CHECK:STDOUT:     %ModAssign.ref: type = name_ref ModAssign, %import_ref.5 [template = constants.%.6]
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %TestOp.decl: TestOp = fn_decl @TestOp [template = constants.%struct.6] {
// CHECK:STDOUT:     %C.ref.loc22_14: type = name_ref C, %C.decl [template = constants.%C]
// CHECK:STDOUT:     %a.loc22_11.1: C = param a
// CHECK:STDOUT:     @TestOp.%a: C = bind_name a, %a.loc22_11.1
// CHECK:STDOUT:     %C.ref.loc22_20: type = name_ref C, %C.decl [template = constants.%C]
// CHECK:STDOUT:     %b.loc22_17.1: C = param b
// CHECK:STDOUT:     @TestOp.%b: C = bind_name b, %b.loc22_17.1
// CHECK:STDOUT:     %C.ref.loc22_26: type = name_ref C, %C.decl [template = constants.%C]
// CHECK:STDOUT:     @TestOp.%return: ref C = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.9: type = import_ref ir4, inst+245, loaded [template = constants.%.2]
// CHECK:STDOUT:   %import_ref.10 = import_ref ir4, inst+263, unloaded
// CHECK:STDOUT:   %TestAssign.decl: TestAssign = fn_decl @TestAssign [template = constants.%struct.7] {
// CHECK:STDOUT:     %C.ref.loc26_18: type = name_ref C, %C.decl [template = constants.%C]
// CHECK:STDOUT:     %.loc26: type = ptr_type C [template = constants.%.7]
// CHECK:STDOUT:     %a.loc26_15.1: C* = param a
// CHECK:STDOUT:     @TestAssign.%a: C* = bind_name a, %a.loc26_15.1
// CHECK:STDOUT:     %C.ref.loc26_25: type = name_ref C, %C.decl [template = constants.%C]
// CHECK:STDOUT:     %b.loc26_22.1: C = param b
// CHECK:STDOUT:     @TestAssign.%b: C = bind_name b, %b.loc26_22.1
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.11: type = import_ref ir4, inst+269, loaded [template = constants.%.6]
// CHECK:STDOUT:   %import_ref.12 = import_ref ir4, inst+286, unloaded
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: interface @Mod {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = file.%import_ref.2
// CHECK:STDOUT:   .Op = file.%import_ref.3
// CHECK:STDOUT:   witness = (file.%import_ref.4)
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: interface @ModAssign {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = file.%import_ref.6
// CHECK:STDOUT:   .Op = file.%import_ref.7
// CHECK:STDOUT:   witness = (file.%import_ref.8)
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: impl @impl.1: C as Mod {
// CHECK:STDOUT:   %Op.decl: Op = fn_decl @Op.1 [template = constants.%struct.1] {
// CHECK:STDOUT:     %C.ref.loc14_15: type = name_ref C, file.%C.decl [template = constants.%C]
// CHECK:STDOUT:     %self.loc14_9.1: C = param self
// CHECK:STDOUT:     %self.loc14_9.2: C = bind_name self, %self.loc14_9.1
// CHECK:STDOUT:     %C.ref.loc14_25: type = name_ref C, file.%C.decl [template = constants.%C]
// CHECK:STDOUT:     %other.loc14_18.1: C = param other
// CHECK:STDOUT:     %other.loc14_18.2: C = bind_name other, %other.loc14_18.1
// CHECK:STDOUT:     %C.ref.loc14_31: type = name_ref C, file.%C.decl [template = constants.%C]
// CHECK:STDOUT:     %return.var: ref C = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %.1: <witness> = interface_witness (%Op.decl) [template = constants.%.4]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Op = %Op.decl
// CHECK:STDOUT:   witness = %.1
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: impl @impl.2: C as ModAssign {
// CHECK:STDOUT:   %Op.decl: Op = fn_decl @Op.3 [template = constants.%struct.4] {
// CHECK:STDOUT:     %C.ref.loc19_20: type = name_ref C, file.%C.decl [template = constants.%C]
// CHECK:STDOUT:     %.loc19_21: type = ptr_type C [template = constants.%.7]
// CHECK:STDOUT:     %self.loc19_14.1: C* = param self
// CHECK:STDOUT:     %self.loc19_14.3: C* = bind_name self, %self.loc19_14.1
// CHECK:STDOUT:     %.loc19_9: C* = addr_pattern %self.loc19_14.3
// CHECK:STDOUT:     %C.ref.loc19_31: type = name_ref C, file.%C.decl [template = constants.%C]
// CHECK:STDOUT:     %other.loc19_24.1: C = param other
// CHECK:STDOUT:     %other.loc19_24.2: C = bind_name other, %other.loc19_24.1
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
// CHECK:STDOUT: fn @Op.1[@impl.1.%self.loc14_9.2: C](@impl.1.%other.loc14_18.2: C) -> @impl.1.%return.var: C {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc15_13.1: {} = struct_literal ()
// CHECK:STDOUT:   %.loc15_13.2: init C = class_init (), @impl.1.%return.var [template = constants.%struct.3]
// CHECK:STDOUT:   %.loc15_14: init C = converted %.loc15_13.1, %.loc15_13.2 [template = constants.%struct.3]
// CHECK:STDOUT:   return %.loc15_14 to @impl.1.%return.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Op.2[%self: Self](%other: Self) -> Self;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Op.3[addr @impl.2.%self.loc19_14.3: C*](@impl.2.%other.loc19_24.2: C) {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Op.4[addr %self: Self*](%other: Self);
// CHECK:STDOUT:
// CHECK:STDOUT: fn @TestOp(%a: C, %b: C) -> %return: C {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %a.ref: C = name_ref a, %a
// CHECK:STDOUT:   %b.ref: C = name_ref b, %b
// CHECK:STDOUT:   %.1: Op = interface_witness_access @impl.1.%.1, element0 [template = constants.%struct.1]
// CHECK:STDOUT:   %.loc23: <bound method> = bound_method %a.ref, %.1
// CHECK:STDOUT:   %.loc22: ref C = splice_block %return {}
// CHECK:STDOUT:   %Op.call: init C = call %.loc23(%a.ref, %b.ref) to %.loc22
// CHECK:STDOUT:   return %Op.call to %return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @TestAssign(%a: C*, %b: C) {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %a.ref: C* = name_ref a, %a
// CHECK:STDOUT:   %.loc27_3.1: ref C = deref %a.ref
// CHECK:STDOUT:   %b.ref: C = name_ref b, %b
// CHECK:STDOUT:   %.1: Op = interface_witness_access @impl.2.%.1, element0 [template = constants.%struct.4]
// CHECK:STDOUT:   %.loc27_6: <bound method> = bound_method %.loc27_3.1, %.1
// CHECK:STDOUT:   %.loc27_3.2: C* = addr_of %.loc27_3.1
// CHECK:STDOUT:   %Op.call: init () = call %.loc27_6(%.loc27_3.2, %b.ref)
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
