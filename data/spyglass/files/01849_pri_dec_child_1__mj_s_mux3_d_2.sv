module mj_s_mux3_d_2 (
    output [1:0] mx_out,
    input [1:0] sel,
    input [1:0] in0,
    input [1:0] in1,
    input [1:0] in2
);
    assign mx_out = (sel == 2'b00) ? in0 :
                    (sel == 2'b01) ? in1 :
                    in2;
endmodule
