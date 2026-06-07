module curve_stx_ve_315_20260111_174806_849331_w47100_attempt8 (
  input wire clk,
  input wire rst_n,
  input wire [1:0] sel_in,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // A Verilog-2001 function is inherently non-void, returning a value via its name.
  // SpyGlass rule STX_VE_315 flags 'return;' without a value expression, even if the
  // function name was assigned a value just before, implying it expects 'return <value>;'.
  function [7:0] my_func;
    input [7:0] a;
    input [1:0] sel;

    reg [7:0] temp_val;

    begin
      temp_val = a; // Initialize temporary value

      // First occurrence of STX_VE_315: 'return;' in an 'if' block
      if (sel == 2'b00) begin
        temp_val = a + 10;
        my_func = temp_val; // Function return value is set
        return; // STX_VE_315 trigger 1: return statement without a value expression
      end

      // Some intermediate logic, ensuring distinct paths for the two triggers.
      temp_val = temp_val * 2;

      // Second occurrence of STX_VE_315: 'return;' in another distinct 'if' block
      if (sel == 2'b01) begin
        my_func = temp_val - 5; // Function return value is set
        return; // STX_VE_315 trigger 2: return statement without a value expression
      end

      // Default path if no early return statements are hit.
      my_func = temp_val; // Ensures a return value for all paths if no explicit return is hit.
    end
  endfunction

  // Instantiate a simple register to use all inputs/outputs and the function.
  // This avoids unused signal warnings and ensures the module is functional.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'd0;
    end else begin
      data_out <= my_func(data_in, sel_in);
    end
  end

endmodule
