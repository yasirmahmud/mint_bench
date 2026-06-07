// Dummy module definitions to resolve SpyGlass ErrorAnalyzeBBox violations

module mj_s_mux3_d_32 (
    output [31:0] mx_out,
    input  [31:0] in2,
    input  [31:0] in1,
    input  [31:0] in0,
    input   [1:0] sel
);
    assign mx_out = (sel == 2'b10) ? in2 :
                    (sel == 2'b01) ? in1 :
                    in0;
endmodule
