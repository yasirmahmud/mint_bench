module my_module_ex1(input [7:0] in_sig, input [2:0] index_var, output reg out_sig);
 always @(index_var) begin out_sig = in_sig[index_var];
 end endmodule
