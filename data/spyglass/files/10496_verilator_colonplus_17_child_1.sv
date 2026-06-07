module test17;
  logic [7:0] status_reg;
  logic [3:0] flags;
  assign flags = status_reg[4 +: 4];
endmodule
