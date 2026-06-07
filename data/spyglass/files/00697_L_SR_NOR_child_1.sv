module L_SR_NOR (
    output reg q,
    output reg qb,
    input s,
    input r
);

  always @(s or r) begin
    if (s == 1'b0 && r == 1'b0) begin
      q = 1'b1;
      qb = 1'b1;
    end else if (s == 1'b0) begin
      q = 1'b1;
      qb = 1'b0;
    end else if (r == 1'b0) begin
      q = 1'b0;
      qb = 1'b1;
    end
  end

endmodule
