// Original complex_multiplier module, with modifications to align with natural language description
module complex_multiplier(
CLK, rst,
input_a_real,input_b_real,output_z_real,
input_a_imag,input_b_imag,output_z_imag
);

input CLK, rst;
input [15:0] input_a_real,input_a_imag;
input [9:0] input_b_real,input_b_imag;
output[15:0] output_z_real,output_z_imag;

wire [15:0] output_real_real,output_imag_imag;
wire [15:0] output_real_imag,output_imag_real;
wire [15:0] output_imag_imag_neg;

multiplier_multibit DUE_REAL_REAL(
.input_a_(input_a_real),
.input_b_(input_b_real),
.output_z(output_real_real),
.CLK(CLK),
.Reset(rst)
);

multiplier_multibit DUE_IMAG_IMAG(
.input_a_(input_a_imag),
.input_b_(input_b_imag),
.output_z(output_imag_imag),
.CLK(CLK),
.Reset(rst)
);

multiplier_multibit DUE_REAL_IMAG(
.input_a_(input_a_real),
.input_b_(input_b_imag),
.output_z(output_real_imag),
.CLK(CLK),
.Reset(rst)
);

multiplier_multibit DUE_IMAG_REAL(
.input_a_(input_a_imag),
.input_b_(input_b_real),
.output_z(output_imag_real),
.CLK(CLK),
.Reset(rst)
);

// --- FIX for functional behavior based on natural language description ---
// The natural language description states: "the real part as the product of the real inputs minus the product of the imaginary inputs".
// This means: output_z_real = (input_a_real * input_b_real) - (input_a_imag * input_b_imag);
// Which translates to: output_z_real = output_real_real - output_imag_imag;
// To achieve subtraction using the 'adder_16bit' (which performs A+B), the subtrahend (output_imag_imag) must be
// negated using 2's complement: -X = ~X + 1.
// The original code used `output_imag_imag ^ 16'b1000000000000000;`, which does not correctly implement 2's complement negation.
// This line has been corrected to ensure the design behavior matches the natural language description.
assign output_imag_imag_neg = ~output_imag_imag + 16'd1; // Correct 2's complement negation

adder_16bit DUT_ADDER_REAL(
.CLK(CLK),
.Reset(rst),
.input_a(output_real_real),
.input_b(output_imag_imag_neg),
.output_z(output_z_real)
);

adder_16bit DUT_ADDER_IMAG(
.CLK(CLK),
.Reset(rst),
.input_a(output_real_imag),
.input_b(output_imag_real),
.output_z(output_z_imag)
);
endmodule
