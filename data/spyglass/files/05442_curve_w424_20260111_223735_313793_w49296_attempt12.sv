module curve_w424_20260111_223735_313793_w49296_attempt12 (
  input wire [7:0] data_in,
  output reg [7:0] result_out,
  output wire [7:0] control_status_out
);

  // Module-level variable that the function will illegally modify
  reg [7:0] module_control_reg; // This is the 'global' variable for W424

  // Function definition: Modifies a module-level variable
  function [7:0] process_data_and_update_control;
    input [7:0] input_val;
    begin
      // W424 violation: Function modifies the module-level variable 'module_control_reg'
      module_control_reg = input_val | 8'hC3; // Distinct operation (bitwise OR) for the side-effect
      process_data_and_update_control = input_val + 2'd2; // Function must return a value
    end
  endfunction

  // Call the function in an always block to ensure its execution and use its return value
  always @(*) begin
    result_out = process_data_and_update_control(data_in);
  end

  // Read the module-level variable to avoid a W528 (variable set but not read) violation
  assign control_status_out = module_control_reg;

endmodule
