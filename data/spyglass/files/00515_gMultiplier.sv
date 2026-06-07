module gMultiplier  (
	a,
	b,
	out
);

	input [15:0] a;
	input [15:0] b;
	output wire [15:0] out;
	reg a_sign;
	reg [7:0] a_exponent;
	reg [7:0] a_mantissa;
	reg b_sign;
	reg [7:0] b_exponent;
	reg [7:0] b_mantissa;
	reg o_sign;
	reg [7:0] o_exponent;
	reg [8:0] o_mantissa;
	reg [15:0] product;
	assign out[15] = o_sign;
	assign out[14:7] = o_exponent;
	assign out[6:0] = o_mantissa[6:0];
	reg [7:0] i_e;
	reg [15:0] i_m;
	wire [7:0] o_e;
	wire [15:0] o_m;
	multiplication_normaliser norm1(
		.in_e(i_e),
		.in_m(i_m),
		.out_e(o_e),
		.out_m(o_m)
	);
	always @(*) begin
		a_sign = a[15];
		if (a[14:7] == 0) begin
			a_exponent = 8'b00000001;
			a_mantissa = {1'b0, a[6:0]};
		end
		else begin
			a_exponent = a[14:7];
			a_mantissa = {1'b1, a[6:0]};
		end
		b_sign = b[15];
		if (b[14:7] == 0) begin
			b_exponent = 8'b00000001;
			b_mantissa = {1'b0, b[6:0]};
		end
		else begin
			b_exponent = b[14:7];
			b_mantissa = {1'b1, b[6:0]};
		end
		o_sign = a_sign ^ b_sign;
		o_exponent = (a_exponent + b_exponent) - 127;
		product = a_mantissa * b_mantissa;
		if (product[15] == 1) begin
			o_exponent = o_exponent + 1;
			product = product >> 1;
		end
		else if ((product[14] != 1) && (o_exponent != 0)) begin
			i_e = o_exponent;
			i_m = product;
			o_exponent = o_e;
			product = o_m;
		end
		o_mantissa = product[14:7];
	end
endmodule
