module neg_reg_init(
  output reg [7:0] out_my_reg
);
  reg [7:0] my_reg = -10; // Resolved SYNTH_5143 by using synthesizable Verilog-2001 initial value assignment

  assign out_my_reg = my_reg; // Resolved W528 by making the register's value observable

endmodule
