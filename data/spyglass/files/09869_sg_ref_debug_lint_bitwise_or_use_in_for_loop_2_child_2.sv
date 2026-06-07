module lint_bitwise_or_ex2;
 localparam [15:0] data_in = 16'hFFFF; // Changed from reg and initial block assignment to localparam
 reg [7:0] result_out;
 integer i;

 always @* begin // Changed from initial block to always @* to address SYNTH_5143
  result_out = 8'h00; // Initialize for each combinational evaluation
  for (i = 0; i < 8; i = i + 1) begin
   // Combine the two bitwise OR assignments into a single assignment per iteration
   // to resolve the W415a 'multiple assignments' violation, while preserving behavior.
   result_out = result_out | {7'b0, data_in[i]} | {7'b0, data_in[i+1]};
  end
 end
endmodule
