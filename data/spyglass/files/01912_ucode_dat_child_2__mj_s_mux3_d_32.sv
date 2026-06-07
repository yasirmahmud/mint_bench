module mj_s_mux3_d_32 (
  output [31:0] mx_out,
  input  [1:0]  sel,
  input  [31:0] in0,
  input  [31:0] in1,
  input  [31:0] in2
);
  assign mx_out = (sel == 2'd0) ? in0 :
                  (sel == 2'd1) ? in1 :
                  (sel == 2'd2) ? in2 :
                                  in0; // Default to in0
endmodule
