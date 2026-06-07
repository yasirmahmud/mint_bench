module mux2_4 (
    output [3:0] out,
    input  [3:0] in0,
    input  [3:0] in1,
    input  [1:0] sel // Assuming sel[1] is the effective select bit due to instantiation {sig, 1'b0}
);
    assign out = sel[1] ? in1 : in0;
endmodule
