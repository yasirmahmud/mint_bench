module ConflictVar_ML_ex1 (input clk, rst, in1, in2, output reg out);
 always @(posedge clk) begin : proc1 reg temp_var;
 if (rst) temp_var = 1'b0;
 else temp_var = in1;
 end always @(posedge clk) begin : proc2 reg temp_var;
 if (rst) temp_var = 1'b0;
 else temp_var = in2;
 end assign out = 1'b0;
 endmodule
