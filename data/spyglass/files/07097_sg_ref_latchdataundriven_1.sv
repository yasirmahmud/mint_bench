module LatchDataUndriven_ex1 (input en, output reg q);
 wire undriven_d;
 always @* if (en) q = undriven_d;
 endmodule
