// Dummy mj_s_mux2_d for linting
module mj_s_mux2_d (output mx_out,
                    input in1, in0, sel);
  assign mx_out = sel ? in1 : in0;
endmodule
