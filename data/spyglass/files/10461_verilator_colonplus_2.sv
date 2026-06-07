module test2;
  reg [15:0] my_reg;
  initial begin
    my_reg[8 :+ 8] = 8'hFF;
  end
endmodule
