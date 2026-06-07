module mux2_6(
        output [5:0] out,
        input [5:0] in1,
        input [5:0] in0,
        input sel
    );
        assign out = sel ? in1 : in0;
    endmodule
