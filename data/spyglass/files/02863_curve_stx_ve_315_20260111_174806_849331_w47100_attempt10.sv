module curve_stx_ve_315_20260111_174806_849331_w47100_attempt10 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  input wire control_signal,
  output reg [7:0] data_out
);

  // A Verilog-2001 function is inherently non-void, returning a value via its name.
  // SpyGlass rule STX_VE_315 flags 'return;' without a value expression.
  // This implies SpyGlass expects 'return <value>;' for non-void functions.
  function [7:0] my_func;
    input [7:0] a_val;
    input control_bit;

    begin // Function body
      // Initialize the function's return value
      my_func = 8'hFF;

      if (control_bit == 1'b1) begin
        my_func = a_val + 1;
        return; // STX_VE_315 Trigger 1: 'return;' without a value expression
      end else begin
        my_func = a_val - 1;
        return; // STX_VE_315 Trigger 2: 'return;' without a value expression
      end
      // Note: Any statements here would be unreachable due to the 'return' in both branches
      // but the function's return value is always set by explicit assignment to 'my_func'.
    end
  endfunction

  // Use the function in a simple register to avoid unused signals and make the module valid.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h00;
    end else begin
      data_out <= my_func(data_in, control_signal);
    end
  end

endmodule
