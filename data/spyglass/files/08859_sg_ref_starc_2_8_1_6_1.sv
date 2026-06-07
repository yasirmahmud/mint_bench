module my_module_ex1(input [3:0] sel_in, output reg out_reg);
 always @(*) begin case (sel_in) 2'b00: out_reg = 1'b0;
 4'b0001: out_reg = 1'b1;
 default: out_reg = 1'b0;
 endcase end endmodule
