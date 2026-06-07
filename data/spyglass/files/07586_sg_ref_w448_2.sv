module w448_ex2_module(in, out1, out2, clk, rst);
input in;
input clk, rst;
output out1, out2;
reg out1, out2;
wire my_reset;
assign my_reset = rst;
always @(posedge clk or posedge my_reset) begin if(my_reset) out1 <= 0;
 else out1 <= in;
 end always @(posedge clk) begin if(my_reset) out2 <= 0;
 else out2 <= in;
 end endmodule
