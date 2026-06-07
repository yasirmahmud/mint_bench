// Intentionally redeclare the same module name to trigger STX_VE_589.
// This is the first duplicate, leading to the first violation.
module duplicate_module_v5 (
  input wire in_data
);
  //
endmodule
