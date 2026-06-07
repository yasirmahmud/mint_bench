module mux8_5 (
	output [4:0] out,
	input [4:0] in0,
	input [4:0] in1,
	input [4:0] in2,
	input [4:0] in3,
	input [4:0] in4,
	input [4:0] in5,
	input [4:0] in6,
	input [4:0] in7,
	input [7:0] sel
);
	// Dummy multiplexer logic using only the relevant select bits
	assign out = (sel[2:0] == 3'b000) ? in0 :
	             (sel[2:0] == 3'b001) ? in1 :
	             (sel[2:0] == 3'b010) ? in2 :
	             (sel[2:0] == 3'b011) ? in3 :
	             (sel[2:0] == 3'b100) ? in4 :
	             (sel[2:0] == 3'b101) ? in5 :
	             (sel[2:0] == 3'b110) ? in6 :
	             (sel[2:0] == 3'b111) ? in7 :
	             in0; // Default case for other sel values
endmodule
