module complex_reset_or (
  input clk,
  input rst_a,
  input rst_b,
  input data_in,
  output reg data_out
);

  always_ff @(posedge clk or negedge (rst_a || rst_b)) begin
    if (!(rst_a || rst_b)) begin
      data_out <= 1'b0;
    end else begin
      data_out <= data_in;
    end
  end

endmodule
