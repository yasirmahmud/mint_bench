module cg_from_lib_ex2 (input clk, input en, input d, output reg q);
 wire gated_clk;
 my_clock_gate_cell cg_inst (.CLK(clk), .EN(en), .GCLK(gated_clk));
 always @(posedge gated_clk) begin q <= d;
 end 
endmodule
