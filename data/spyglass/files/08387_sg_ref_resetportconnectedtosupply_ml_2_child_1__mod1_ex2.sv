module mod1_ex2 (input clk, output out_q);
 assign out_q = 1'b0; // Changed to preserve original functional behavior (out_q was always 0 due to rst_n being tied to 0) and resolve the FlopSRConst violation.
endmodule
