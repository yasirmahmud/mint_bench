module LatchGatedClock_ex2 (input clk, input en, input d, output reg q);
 wire gated_en = clk & en;
 always @* begin if (gated_en) begin q = d;
 end end endmodule
