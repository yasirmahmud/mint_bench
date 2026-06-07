// mj_s_mux2_d_32
module mj_s_mux2_d_32(
    output [31:0] mx_out,
    input         sel,
    input  [31:0] in0,
    input  [31:0] in1
);
    assign mx_out = sel ? in1 : in0;
endmodule
