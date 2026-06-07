// Dummy mj_s_mux2_d_32 for linting
module mj_s_mux2_d_32 (output [31:0] mx_out,
                       input [31:0] in1, in0,
                       input sel);
  assign mx_out = sel ? in1 : in0;
endmodule
