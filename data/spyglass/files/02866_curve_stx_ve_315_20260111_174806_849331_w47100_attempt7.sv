module curve_stx_ve_315_20260111_174806_849331_w47100_attempt7 (
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
    reg [7:0] func_result;

    begin
      // First occurrence of STX_VE_315: 'return;' in an 'if' block
      if (sel == 2'b00) begin
        func_result = a + 1;
        my_func = func_result; // Function return value is set
        return; // STX_VE_315 trigger 1: return statement without a value expression
      end

      // Second occurrence of STX_VE_315: 'return;' in a 'case' block
      case (sel)
        2'b01: begin
          func_result = a * 2;
          my_func = func_result; // Function return value is set
          return; // STX_VE_315 trigger 2: return statement without a value expression
        end
        2'b10: begin
          my_func = a - 1; // This branch explicitly assigns to my_func and exits implicitly.
        end
        default: begin
          my_func = a; // Default branch explicitly assigns to my_func and exits implicitly.
        end
      endcase
      // If control reaches here, an implicit return occurs with the last assigned value to my_func.
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
