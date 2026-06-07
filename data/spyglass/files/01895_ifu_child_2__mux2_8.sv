module mux2_8 (output [7:0] out, input [7:0] in0, input [7:0] in1, input sel);
    assign out = sel ? in1 : in0;
endmodule
