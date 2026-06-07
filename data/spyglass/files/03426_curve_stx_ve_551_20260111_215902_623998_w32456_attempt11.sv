module (
  input i_clk,
  input i_reset_n,
  input i_data,
  output reg o_data
);

  always @(posedge i_clk or negedge i_reset_n) begin
    if (!i_reset_n) begin
      o_data <= 1'b0;
    end else begin
      o_data <= i_data;
    end
  end

endmodule
