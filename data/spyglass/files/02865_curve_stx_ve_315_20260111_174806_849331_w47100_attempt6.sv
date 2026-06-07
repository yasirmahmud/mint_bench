module curve_stx_ve_315_20260111_174806_849331_w47100_attempt6 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // A Verilog-2001 function is inherently non-void, returning a value via its name.
  // Using 'return;' without a value expression in such a function will trigger STX_VE_315.
  function [7:0] my_func;
    input [7:0] a;
    reg [7:0] temp_val;
    begin
      if (a > 10) begin
        temp_val = a + 1;
        my_func = temp_val;
        return; // First occurrence of STX_VE_315: return without value in non-void function
      end else if (a < 5) begin
        temp_val = a * 2;
        my_func = temp_val;
        return; // Second occurrence of STX_VE_315: return without value in non-void function
      end else begin
        my_func = a;
      end
    end
  endfunction

  // Instantiate a simple register to use all inputs/outputs and the function,
  // avoiding unused signal warnings and ensuring the module is functional.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'd0;
    end else begin
      data_out <= my_func(data_in);
    end
  end

endmodule
