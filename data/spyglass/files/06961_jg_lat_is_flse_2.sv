module latch_chain_2 (
  input wire din,
  input wire en,
  output reg dout
);

  reg internal_reg;

  always_latch begin
    if (en) begin
      internal_reg = din;
    end
  end

  always_latch begin
    if (en) begin
      dout = internal_reg;
    end
  end

endmodule
