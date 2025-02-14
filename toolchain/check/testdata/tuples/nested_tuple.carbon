// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

var x: ((i32, i32), i32) = ((12, 76), 6);

// CHECK:STDOUT: --- nested_tuple.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct: Int32 = struct_value () [template]
// CHECK:STDOUT:   %.2: type = tuple_type (type, type) [template]
// CHECK:STDOUT:   %.3: type = tuple_type ((type, type), type) [template]
// CHECK:STDOUT:   %.4: type = tuple_type (i32, i32) [template]
// CHECK:STDOUT:   %.5: type = tuple_type ((i32, i32), i32) [template]
// CHECK:STDOUT:   %.6: type = ptr_type (i32, i32) [template]
// CHECK:STDOUT:   %.7: type = tuple_type ((i32, i32)*, i32) [template]
// CHECK:STDOUT:   %.8: type = ptr_type ((i32, i32)*, i32) [template]
// CHECK:STDOUT:   %.9: i32 = int_literal 12 [template]
// CHECK:STDOUT:   %.10: i32 = int_literal 76 [template]
// CHECK:STDOUT:   %.11: i32 = int_literal 6 [template]
// CHECK:STDOUT:   %tuple.1: (i32, i32) = tuple_value (%.9, %.10) [template]
// CHECK:STDOUT:   %tuple.2: ((i32, i32), i32) = tuple_value (%tuple.1, %.11) [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .x = %x
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %import_ref.1: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct]
// CHECK:STDOUT:   %int.make_type_32.loc7_10: init type = call constants.%struct() [template = i32]
// CHECK:STDOUT:   %import_ref.2: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct]
// CHECK:STDOUT:   %int.make_type_32.loc7_15: init type = call constants.%struct() [template = i32]
// CHECK:STDOUT:   %.loc7_18: (type, type) = tuple_literal (%int.make_type_32.loc7_10, %int.make_type_32.loc7_15)
// CHECK:STDOUT:   %import_ref.3: Int32 = import_ref ir3, inst+3, loaded [template = constants.%struct]
// CHECK:STDOUT:   %int.make_type_32.loc7_21: init type = call constants.%struct() [template = i32]
// CHECK:STDOUT:   %.loc7_24.1: ((type, type), type) = tuple_literal (%.loc7_18, %int.make_type_32.loc7_21)
// CHECK:STDOUT:   %.loc7_24.2: type = value_of_initializer %int.make_type_32.loc7_10 [template = i32]
// CHECK:STDOUT:   %.loc7_24.3: type = converted %int.make_type_32.loc7_10, %.loc7_24.2 [template = i32]
// CHECK:STDOUT:   %.loc7_24.4: type = value_of_initializer %int.make_type_32.loc7_15 [template = i32]
// CHECK:STDOUT:   %.loc7_24.5: type = converted %int.make_type_32.loc7_15, %.loc7_24.4 [template = i32]
// CHECK:STDOUT:   %.loc7_24.6: type = converted %.loc7_18, constants.%.4 [template = constants.%.4]
// CHECK:STDOUT:   %.loc7_24.7: type = value_of_initializer %int.make_type_32.loc7_21 [template = i32]
// CHECK:STDOUT:   %.loc7_24.8: type = converted %int.make_type_32.loc7_21, %.loc7_24.7 [template = i32]
// CHECK:STDOUT:   %.loc7_24.9: type = converted %.loc7_24.1, constants.%.5 [template = constants.%.5]
// CHECK:STDOUT:   %x.var: ref ((i32, i32), i32) = var x
// CHECK:STDOUT:   %x: ref ((i32, i32), i32) = bind_name x, %x.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @__global_init() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc7_30: i32 = int_literal 12 [template = constants.%.9]
// CHECK:STDOUT:   %.loc7_34: i32 = int_literal 76 [template = constants.%.10]
// CHECK:STDOUT:   %.loc7_36.1: (i32, i32) = tuple_literal (%.loc7_30, %.loc7_34)
// CHECK:STDOUT:   %.loc7_39: i32 = int_literal 6 [template = constants.%.11]
// CHECK:STDOUT:   %.loc7_40.1: ((i32, i32), i32) = tuple_literal (%.loc7_36.1, %.loc7_39)
// CHECK:STDOUT:   %.loc7_40.2: ref (i32, i32) = tuple_access file.%x.var, element0
// CHECK:STDOUT:   %.loc7_36.2: ref i32 = tuple_access %.loc7_40.2, element0
// CHECK:STDOUT:   %.loc7_36.3: init i32 = initialize_from %.loc7_30 to %.loc7_36.2 [template = constants.%.9]
// CHECK:STDOUT:   %.loc7_36.4: ref i32 = tuple_access %.loc7_40.2, element1
// CHECK:STDOUT:   %.loc7_36.5: init i32 = initialize_from %.loc7_34 to %.loc7_36.4 [template = constants.%.10]
// CHECK:STDOUT:   %.loc7_36.6: init (i32, i32) = tuple_init (%.loc7_36.3, %.loc7_36.5) to %.loc7_40.2 [template = constants.%tuple.1]
// CHECK:STDOUT:   %.loc7_40.3: init (i32, i32) = converted %.loc7_36.1, %.loc7_36.6 [template = constants.%tuple.1]
// CHECK:STDOUT:   %.loc7_40.4: ref i32 = tuple_access file.%x.var, element1
// CHECK:STDOUT:   %.loc7_40.5: init i32 = initialize_from %.loc7_39 to %.loc7_40.4 [template = constants.%.11]
// CHECK:STDOUT:   %.loc7_40.6: init ((i32, i32), i32) = tuple_init (%.loc7_40.3, %.loc7_40.5) to file.%x.var [template = constants.%tuple.2]
// CHECK:STDOUT:   %.loc7_41: init ((i32, i32), i32) = converted %.loc7_40.1, %.loc7_40.6 [template = constants.%tuple.2]
// CHECK:STDOUT:   assign file.%x.var, %.loc7_41
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
