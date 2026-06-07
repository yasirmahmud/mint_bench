module param_mod_ex1 (input clk, output out);
 parameter WIDTH = 8;
 reg [WIDTH-1:0] data_reg;
 always @(posedge clk) data_reg <= data_reg + 1;
 assign out = data_reg[0];
 endmodule
