module lint_bitwise_or_ex2;
 localparam [15:0] data_in = 16'hFFFF; // Changed from reg and initial block assignment to localparam
 reg [7:0] result_out;
 integer i;

 always @* begin // Changed from initial block to always @* to address SYNTH_5143
  result_out = 8'h00; // Initialize for each combinational evaluation
  for (i = 0; i < 8; i = i + 1) begin
   result_out = result_out | {7'b0, data_in[i]}; // Explicitly extend 1-bit data_in[i] to 8 bits to resolve W116
   result_out = result_out | {7'b0, data_in[i+1]}; // Explicitly extend 1-bit data_in[i+1] to 8 bits to resolve W116
  end
 end
endmodule
