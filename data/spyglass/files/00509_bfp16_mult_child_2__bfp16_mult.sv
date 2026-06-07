module bfp16_mult  (
	rst,
	A,
	B,
	O
);

	input rst;
	input [15:0] A;
	input [15:0] B;
	output reg [15:0] O;

	wire a_sign;
	wire b_sign;
	wire [7:0] a_exponent;
	wire [7:0] b_exponent;
	wire [7:0] a_mantissa;
	wire [7:0] b_mantissa;

	reg o_sign;
	reg [7:0] o_exponent;
	reg [8:0] o_mantissa;

	reg [15:0] multiplier_a_in;
	reg [15:0] multiplier_b_in;
	wire [15:0] multiplier_out;

	assign a_sign = A[15];
	assign a_exponent[7:0] = A[14:7];
	assign a_mantissa[7:0] = {1'b1, A[6:0]};

	assign b_sign = B[15];
	assign b_exponent[7:0] = B[14:7];
	assign b_mantissa[7:0] = {1'b1, B[6:0]};

	gMultiplier M1(
		.a(multiplier_a_in),
		.b(multiplier_b_in),
		.out(multiplier_out)
	);

	wire [16:1] sv2v_tmp_C4007;
	assign sv2v_tmp_C4007 = A;
	always @(*) multiplier_a_in = sv2v_tmp_C4007;

	wire [16:1] sv2v_tmp_7E497;
	assign sv2v_tmp_7E497 = B;
	always @(*) multiplier_b_in = sv2v_tmp_7E497;

	always @(*)
		if (rst == 1'b1)
			O = 16'h0000; // Fixed: Changed 32'd0 to 16'h0000 to match O's declared width [15:0]
		else if ((a_exponent == 255) && (a_mantissa != 0)) begin
			o_sign = a_sign;
			o_exponent = 255;
			o_mantissa = a_mantissa;
			O = {o_sign, o_exponent, o_mantissa[6:0]};
		end
		else if ((b_exponent == 255) && (b_mantissa != 0)) begin
			o_sign = b_sign;
			o_exponent = 255;
			o_mantissa = b_mantissa;
			O = {o_sign, o_exponent, o_mantissa[6:0]};
		end
		else if (((a_exponent == 0) && (a_mantissa == 0)) || ((b_exponent == 0) && (b_mantissa == 0))) begin
			o_sign = a_sign ^ b_sign;
			o_exponent = 0;
			o_mantissa = 0;
			O = {o_sign, o_exponent, o_mantissa[6:0]};
		end
		else if ((a_exponent == 255) || (b_exponent == 255)) begin
			o_sign = a_sign;
			o_exponent = 255;
			o_mantissa = 0;
			O = {o_sign, o_exponent, o_mantissa[6:0]};
		end
		else if ((A == 'd0) && (B == 'd0)) begin
			o_sign = 0;
			o_exponent = 0;
			o_mantissa = 0;
			O = {o_sign, o_exponent, o_mantissa[6:0]};
		end
		else begin
			o_sign = multiplier_out[15];
			o_exponent = multiplier_out[14:7];
			o_mantissa = multiplier_out[6:0];
			O = {o_sign, o_exponent, o_mantissa[6:0]};
		end
endmodule
