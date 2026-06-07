module curve_synth_5395_20260110_132601_attempt1 (
  input clk,
  input rst,
  input data_in,
  output reg out_reg
);

  always @ (posedge clk or posedge rst or posedge data_in) begin
    if (rst) begin
      out_reg <= 1'b0;
    end else begin
      out_reg <= data_in;
    end
  end

endmodule
