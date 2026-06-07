// Behavioral model for 2-input, 32-bit multiplexer
// Assumes select line sel[0] is used for selection (0->in0, 1->in1).
// sel[1] is ignored, as per common naming convention 'mux2' for 2-input mux.
module mux2_32 (output [31:0] out,
                input [31:0] in0, in1,
                input [1:0] sel);
    assign out = (sel[0] == 1'b0) ? in0 : in1;
endmodule
