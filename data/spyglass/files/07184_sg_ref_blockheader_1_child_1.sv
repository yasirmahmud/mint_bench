module BlockHeader_ex1 (input in_port, output reg out_port);
 reg temp_reg;
 initial begin : my_initial_block
  temp_reg = in_port;
  out_port = temp_reg;
 end
endmodule
