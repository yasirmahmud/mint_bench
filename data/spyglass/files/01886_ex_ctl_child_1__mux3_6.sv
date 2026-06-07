module mux3_6(
        output [5:0] out,
        input [5:0] in2,
        input [5:0] in1,
        input [5:0] in0,
        input [2:0] sel
    );
        assign out = sel[2] ? in2 : (sel[1] ? in1 : in0);
    endmodule
