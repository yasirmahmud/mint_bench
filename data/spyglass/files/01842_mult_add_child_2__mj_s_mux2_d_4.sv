// Dummy mj_s_mux2_d_4 for linting
module mj_s_mux2_d_4 (output [3:0] mx_out,
                      input [3:0] in1, in0,
                      input sel);
  assign mx_out = sel ? in1 : in0;
endmodule
