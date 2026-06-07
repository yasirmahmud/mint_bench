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
    for (int j = 0; j < 8; j++) begin
      // Signal 'out_accum' is used repetitively in the statement inside loop body.
      out_accum <= out_accum ^ (out_accum >> 1) ^ in_val[j];
    end
  end
end

endmodule
