module FlopClockUndriven_ex2 (input d, output reg q);
 wire undriven_clk;
 always @(posedge undriven_clk) begin q <= d;
 end endmodule
