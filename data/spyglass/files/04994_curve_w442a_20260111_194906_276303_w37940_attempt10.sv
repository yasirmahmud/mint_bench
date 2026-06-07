module curve_w442a_20260111_194906_276303_w37940_attempt10 (
    input clk,
    input rst_n,
    input d_in,
    output reg q_out
);

  // This 'always' block is sensitive to both 'posedge clk' and 'negedge rst_n',
  // indicating an asynchronous reset 'rst_n'.
  // SpyGlass rule W442a triggers because the very first statement inside the 'always' block
  // is a local 'integer' declaration, NOT an 'if' statement that explicitly checks
  // the asynchronous reset condition (e.g., 'if (!rst_n)').
  // The rule mandates that for an asynchronously reset/set always block, the reset condition
  // must be checked by an 'if' statement at the very top level of the block.
  always @(posedge clk or negedge rst_n) begin
    // W442a violation: An 'integer' declaration is at the top level instead of the 'if (!rst_n)' check.
    integer some_local_var; 
    
    if (!rst_n) begin
      q_out <= 1'b0;
      some_local_var = 0; // Use the local variable to avoid unused signal warnings
    end else begin
      q_out <= d_in;
      some_local_var = 1; // Use the local variable
    end
  end

endmodule
