module mux4_5 (
	output [4:0] out,
	input [4:0] in0,
	input [4:0] in1,
	input [4:0] in2,
	input [4:0] in3,
	input [3:0] sel
);
	// Dummy multiplexer logic using only the relevant select bits
	assign out = (sel[1:0] == 2'b00) ? in0 :
	             (sel[1:0] == 2'b01) ? in1 :
	             (sel[1:0] == 2'b10) ? in2 :
	             (sel[1:0] == 2'b11) ? in3 :
	             in0; // Default case for other sel values
endmodule
