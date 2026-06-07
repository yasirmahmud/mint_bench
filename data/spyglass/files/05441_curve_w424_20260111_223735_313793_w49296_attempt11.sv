module curve_w424_20260111_223735_313793_w49296_attempt11 (
  input wire [7:0] data_in,
  output reg [7:0] result_out
);

  // Module-level variable that the function will illegally modify
  reg [7:0] module_config_reg;

  // Function definition
  function [7:0] update_config_and_return_status;
    input [7:0] input_val;
    begin
      // W424 violation: Function modifies a module-level variable (global_data)
      module_config_reg = ~input_val; // Distinct operation to change the module-level variable
      update_config_and_return_status = input_val + 1'b1; // Function must return a value
    end
  endfunction

  // Instantiate the function to ensure it's called and inputs/outputs are used
  always @(*) begin
    result_out = update_config_and_return_status(data_in);
  end

endmodule
