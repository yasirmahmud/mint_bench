module my_module_ex2;
reg [1:0] sel;
reg out;
always @* begin case (sel) 2'b0X: out = 1'b1;
 default: out = 1'b0;
 endcase end endmodule
