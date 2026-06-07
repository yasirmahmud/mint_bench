module mixed_reset_edges_ex1(input clk, input rst_n, output reg q);
  // The original design effectively made 'q' track 'rst_n' due to
  // the 'if (!rst_n) q <= 1'b0; else if (rst_n) q <= 1'b1;' structure.
  // The 'clk' in the sensitivity list was not used for any data manipulation,
  // and including both 'posedge rst_n' and 'negedge rst_n' is a violation.
  // To preserve the functional behavior (q always equals rst_n) and resolve
  // the 'bothedges' and 'badimplicitSM1' violations, q is made a combinational
  // output of rst_n using an always @* block.
  always @* begin
    q = rst_n;
  end
endmodule
