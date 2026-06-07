module top_ex1 (input clk, output reg out);
 my_sub_module_ex1 u_sub_inst (.i_clk(clk), .o_out(out));
 always @(posedge clk) begin out <= ~out;
 end
endmodule
