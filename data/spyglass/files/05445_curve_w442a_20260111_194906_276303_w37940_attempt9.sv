module curve_w442a_20260111_194906_276303_w37940_attempt9 (
    input clk,
    input rst_n,
    input [1:0] sel,
    input d0,
    input d1,
    output reg q_out
);

  // This 'always' block is sensitive to both 'posedge clk' and 'negedge rst_n',
  // indicating an asynchronous reset 'rst_n'.
  // SpyGlass rule W442a triggers because the very first statement inside the 'always' block
  // is a 'case' statement, not an 'if' statement that explicitly checks the asynchronous reset condition (e.g., 'if (!rst_n)').
  // The rule mandates that for an asynchronously reset/set always block, the reset condition
  // must be checked by an 'if' statement at the very top level of the block.
  always @(posedge clk or negedge rst_n) begin
    // W442a violation: A 'case' statement is at the top level instead of the 'if (!rst_n)' check.
    case (sel) 
      2'b00: q_out <= d0;
      2'b01: q_out <= d1;
      default: q_out <= 1'b0;
    endcase
  end

endmodule
