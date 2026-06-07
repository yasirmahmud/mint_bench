module STARC05_2_1_7_3_ex1 (input in1, output [3:0] sig);
 reg [3:0] sig_r;
 assign sig = sig_r;
 always @* begin sig_r = 4'b0000;
 sig_r[2] = in1;
 end endmodule
