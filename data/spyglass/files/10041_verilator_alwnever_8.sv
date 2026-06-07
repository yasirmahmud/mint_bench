module example_8;
  reg [63:0] large_reg;
  always @* begin
    large_reg = 64'hDEADBEEF_CAFEBABE;
  end
endmodule
