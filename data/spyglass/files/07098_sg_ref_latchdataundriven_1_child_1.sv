module LatchDataUndriven_ex1 (input en, input d_in, output reg q);
  always @* if (en) q = d_in;
endmodule
