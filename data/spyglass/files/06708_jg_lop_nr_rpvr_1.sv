module repetitive_use_1 (
  input clk,
  input rst,
  input [7:0] data_in,
  output reg [7:0] data_out
);

always @(posedge clk or posedge rst) begin
  if (rst) begin
    data_out <= 8'b0;
  end else begin
    for (int i = 0; i < 4; i++) begin
      // Signal 'data_out' is used repetitively in the statement inside loop body.
      data_out <= data_out + data_out[i*2 + 1] - data_out[i*2];
    end
  end
end

endmodule
