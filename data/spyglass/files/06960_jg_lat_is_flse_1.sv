module latch_chain_1 (
  input wire data_in,
  input wire enable,
  output reg data_out
);

  reg intermediate_latch_out;

  always @* begin
    if (enable) begin
      intermediate_latch_out = data_in;
    end
  end

  always @* begin
    if (enable) begin
      data_out = intermediate_latch_out;
    end
  end

endmodule
