// This submodule contains actual parameters and is not empty (it has ports and logic).
// This design choice is critical for avoiding other warnings:
// - It prevents 'WarnAnalyzeBBox' because the module has a valid, non-empty definition.
// - By having existing parameters (e.g., BASE_VALUE), it indicates that the module
//   supports parameters. This helps differentiate the issue as a reference to a
//   non-existent *parameter* (triggering WRN_1473) rather than a non-existent
//   *instance* or a module with no parameters at all (which often triggers SYNTH_5164).
module sub_module_with_params # (
  parameter BASE_VALUE = 16'hFFFF, // An existing parameter to show module supports params
  parameter OFFSET = 4             // Another existing parameter
) (
  input in_signal,
  output out_signal
);
  // Simple logic to utilize the parameters and signals, preventing unused warnings.
  wire temp_wire;
  assign temp_wire = in_signal && (BASE_VALUE[OFFSET % 16] == 1'b1); // Using parameters
  assign out_signal = temp_wire;
endmodule
