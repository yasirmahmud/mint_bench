module curve_w442a_20260111_194906_276303_w37940_attempt8 (
    input clk,
    input rst_n,
    input d_in,
    output reg q_out
);

  // This 'always' block is sensitive to both 'posedge clk' and 'negedge rst_n',
  // indicating an asynchronous reset 'rst_n'.
  // However, the very first statement inside the 'always' block is a direct assignment ('q_out <= d_in;'),
  // not an 'if' statement that explicitly checks the asynchronous reset condition (e.g., 'if (!rst_n)').
  // This directly triggers SpyGlass rule W442a: "Asynchronously reset/set always block has missing 'if' statement at the top level".
  always @(posedge clk or negedge rst_n) begin
    // W442a violation: The asynchronous reset 'rst_n' is in the sensitivity list,
    // but no 'if' statement checking for it is present at the top level of the block.
    q_out <= d_in;
  end

endmodule
