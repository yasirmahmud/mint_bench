module mult_oper_var_ex1(output reg [7:0] out);
 reg [7:0] val;
 initial begin val = 8'd1;
 out = val++ + val++;
 end endmodule
