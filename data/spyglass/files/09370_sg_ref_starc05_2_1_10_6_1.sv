module my_module_ex1();
reg [1:0] sel_reg;
reg out_reg;
initial begin sel_reg = 2'b00;
case(sel_reg)2'b00: out_reg = 1'b0;
default: out_reg = 1'b1;
endcase end endmodule
