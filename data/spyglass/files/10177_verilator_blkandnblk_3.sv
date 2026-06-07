module ex3;
  reg [1:0] c;
  always @* begin
    c[0] = 1'b1;
    c[1] <= 1'b0;
    c = 2'b10; // Overlaps with c[0] and c[1]
  end
endmodule
