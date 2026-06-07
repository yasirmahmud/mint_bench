`define SC_BOTTOM_POR_VALUE 32'h00000000

// Behavioral model for 3-input, 30-bit multiplexer
// Assumes select lines sel[1:0] are used for selecting in0, in1, in2 respectively.
// sel[2] is ignored. Default to in0 if sel[1:0] is 2'b11 or other unused values.
module mux3_30 (output [29:0] out,
                input [29:0] in0, in1, in2,
                input [2:0] sel);
    assign out = (sel[1:0] == 2'b00) ? in0 :
                 (sel[1:0] == 2'b01) ? in1 :
                 (sel[1:0] == 2'b10) ? in2 : in0;
endmodule
