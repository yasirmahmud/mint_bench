// Dummy mj_s_mux4_d_32 for linting
module mj_s_mux4_d_32 (output [31:0] mx_out,
                       input [1:0] sel,
                       input [31:0] in0, in1, in2, in3);
  assign mx_out = (sel == 2'b00) ? in0 :
                  (sel == 2'b01) ? in1 :
                  (sel == 2'b10) ? in2 : in3;
endmodule
