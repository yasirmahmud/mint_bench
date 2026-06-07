`celldefine module my_ff_cell(D, CLK, Q);
 input D, CLK;
 output Q;
 reg Q;
 always @(posedge CLK) Q <= D;
 endmodule
 `endcelldefine module top_module_ex2 (input_sig, clk_sig, output_sig);
 input input_sig, clk_sig;
 output output_sig;
 //synopsys set_dont_touch my_ff_cell my_ff_cell u_ff (.D(input_sig), .CLK(clk_sig), .Q(output_sig)); endmodule
