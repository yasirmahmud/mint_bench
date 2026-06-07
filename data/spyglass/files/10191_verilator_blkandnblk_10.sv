module ex10;
  reg j;
  assign j = 1'b1; // Continuous assignment (implicitly blocking)
  always @* begin
    j <= 1'b0;
  end
endmodule
