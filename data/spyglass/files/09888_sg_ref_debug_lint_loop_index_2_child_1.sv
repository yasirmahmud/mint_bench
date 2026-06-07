module debug_lint_loop_index_ex2;
 reg [7:0] u_val;
 integer i;

 initial begin
  u_val = 8'd0; // Initialize u_val to prevent 'read but never set' violation.
 end

 always @(*) begin for (i = 0; i < u_val; i = i + 1) begin end end
endmodule
