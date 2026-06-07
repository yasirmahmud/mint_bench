module conflict_var_ex2(input clk, input rst, input in1, input in2, output reg out);
 reg shared_var;
 always @(posedge clk) begin if (rst) shared_var <= 1'b0;
 else shared_var <= in1;
 end always @(posedge clk) begin if (rst) shared_var <= 1'b0;
 else shared_var <= in2;
 end assign out = shared_var;
 endmodule
