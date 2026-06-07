module ex9;
  reg [7:0] i;
  always @* begin
    i[3:0] = 4'hF;
    i[7:4] <= 4'hA;
    i = 8'hFF; // Overlaps with both
  end
endmodule
