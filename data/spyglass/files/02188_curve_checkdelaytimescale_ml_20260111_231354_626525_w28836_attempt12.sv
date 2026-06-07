module delay_example (
  input wire i_clk,
  input wire i_data,
  output reg o_q
);

  always @(posedge i_clk) begin
    o_q <= #4 i_data;
  end

endmodule
