module var_in_case_inside_ex1(input [1:0] sel, output reg out);
 reg [1:0] my_var;
 always @(*) begin my_var = 2'b01;
 casez (sel) inside 2'b00: out = 1'b0;
 my_var: out = 1'b1;
 default: out = 1'bx;
 endcase end endmodule
