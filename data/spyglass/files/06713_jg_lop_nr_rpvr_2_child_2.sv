module repetitive_use_2 (
  input clk,
  input rst,
  input [7:0] in_val,
  output reg [7:0] out_accum
);

always @(posedge clk or posedge rst) begin
  if (rst) begin
    out_accum <= 8'b0;
  end else begin
    // Declare next_out_accum as a local variable within this block.
    // This clarifies its role as a temporary combinatorial variable for this cycle,
    // resolving SpyGlass violations related to multiple assignments to a potential flip-flop.
    reg [7:0] next_out_accum;

    // Initialize the temporary variable with the current value of out_accum
    next_out_accum = out_accum;

    for (int j = 0; j < 8; j++) begin
      // Apply updates to the temporary variable using blocking assignment.
      // This ensures each iteration uses the result from the previous iteration.
      next_out_accum = next_out_accum ^ (next_out_accum >> 1) ^ {7'b0, in_val[j]};
    end
    // After the loop, assign the final accumulated result to out_accum using non-blocking assignment.
    out_accum <= next_out_accum;
  end
end

endmodule
