module ex17;
  reg q;
  always @* begin
    q = 1'b1;
    #1 q <= 1'b0;
  end
endmodule
