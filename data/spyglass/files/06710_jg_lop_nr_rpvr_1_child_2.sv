module repetitive_use_1 (
  input clk,
  input rst,
  input [7:0] data_in,
  output reg [7:0] data_out
);

  // The previous addition of 'unused_data_in' to resolve W240 for 'data_in'
  // has now introduced W528 because 'unused_data_in' itself is not read.
  // Since 'data_in' is not functionally used in the 'data_out' logic,
  // removing the 'unused_data_in' wire resolves the W528 violation
  // without altering the functional behavior of 'data_out'.

always @(posedge clk or posedge rst) begin
  if (rst) begin
    data_out <= 8'b0;
  end else begin
    data_out <= data_out + data_out[7] - data_out[6];
  end
end

endmodule
