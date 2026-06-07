module curve_stx_ve_458_20260111_011501_attempt7 (
  input wire [7:0] data_in_a,
  input wire [7:0] data_in_b,
  input wire [7:0] selector_val,
  output reg [7:0] calculated_output
);

  // A standard Verilog-2001 function. By default, its local variables are static.
  // However, SpyGlass examples for STX_VE_458 show that non-blocking assignments (NBAs)
  // to such local 'reg' variables within a function are flagged as "Illegal use of automatic variable".
  // This suggests SpyGlass interprets this specific combination (NBA to a local variable in a function)
  // as problematic, similar to how an automatic variable would behave if its scope ended before the NBA completed.
  function [7:0] process_data (
    input [7:0] operand_a,
    input [7:0] operand_b,
    input [7:0] control_select
  );
    // Declare 5 local 'reg' variables. These are static by LRM in a non-automatic function.
    // Each non-blocking assignment to these variables is expected to trigger one STX_VE_458 violation.
    reg [7:0] temp_res_0; // STX_VE_458 violation #1
    reg [7:0] temp_res_1; // STX_VE_458 violation #2
    reg [7:0] temp_res_2; // STX_VE_458 violation #3
    reg [7:0] temp_res_3; // STX_VE_458 violation #4
    reg [7:0] temp_res_4; // STX_VE_458 violation #5

    begin
      // Performing non-blocking assignments to the local static 'reg' variables.
      // This pattern directly reflects the behavior seen in SpyGlass examples for STX_VE_458.
      temp_res_0 <= operand_a + control_select;
      temp_res_1 <= operand_b - control_select;
      temp_res_2 <= operand_a ^ operand_b;
      temp_res_3 <= (operand_a & operand_b) | control_select;
      temp_res_4 <= (control_select > 4'd7) ? operand_a : operand_b;
      
      // Ensure all local temporary variables are used to avoid 'unused signal' warnings.
      process_data = temp_res_0 + temp_res_1 + temp_res_2 + temp_res_3 + temp_res_4;
    end
  endfunction

  // Instantiate the function in an always @* block to drive the output.
  // This ensures combinational logic and avoids latches.
  always @* begin
    calculated_output = process_data(data_in_a, data_in_b, selector_val);
  end

endmodule
