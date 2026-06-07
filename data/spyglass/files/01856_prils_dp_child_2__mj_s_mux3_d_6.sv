// mj_s_mux3_d_6
module mj_s_mux3_d_6(
    output [5:0] mx_out,
    input  [1:0] sel,
    input  [5:0] in0,
    input  [5:0] in1,
    input  [5:0] in2
);
    assign mx_out = (sel == 2'b00) ? in0 :
                    (sel == 2'b01) ? in1 :
                    (sel == 2'b10) ? in2 :
                                     6'b0; // Default for 2'b11 to avoid 'X' propagation
endmodule
