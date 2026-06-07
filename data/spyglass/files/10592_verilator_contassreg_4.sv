module test4(input in_b);
  reg [1:0] state_reg;
  assign state_reg = {in_b, 1'b0};
endmodule
