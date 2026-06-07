module W488_ex2;
 reg [3:0] data_bus;
 reg out_reg;
 always @(data_bus) begin out_reg = data_bus[0] | data_bus[1];
 end endmodule
