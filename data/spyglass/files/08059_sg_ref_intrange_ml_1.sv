module my_module_ex1(input clk, input rst, output reg [7:0] out_reg);
 integer my_int_var;
 always @(posedge clk or posedge rst) begin if (rst) begin my_int_var = 0;
 out_reg <= 0;
 end else begin my_int_var = my_int_var + 1;
 out_reg <= my_int_var[7:0];
 end end endmodule
