module complex_multiplier(
    input CLK,
    input rst,
    input signed [15:0] input_a_real,
    input signed [15:0] input_b_real,
    input signed [15:0] input_a_imag,
    input signed [15:0] input_b_imag,
    output reg signed [15:0] output_z_real,
    output reg signed [15:0] output_z_imag
);

    // Intermediate products can be up to 32 bits for 16x16 multiplication
    wire signed [31:0] ac_mult;
    wire signed [31:0] bd_mult;
    wire signed [31:0] ad_mult;
    wire signed [31:0] bc_mult;
    
    assign ac_mult = input_a_real * input_b_real;
    assign bd_mult = input_a_imag * input_b_imag;
    assign ad_mult = input_a_real * input_b_imag;
    assign bc_mult = input_a_imag * input_b_real;

    always @(posedge CLK or posedge rst) begin
        if (rst) begin
            output_z_real <= 16'd0;
            output_z_imag <= 16'd0;
        end else begin
            // Complex multiplication: (AC - BD) + j(AD + BC)
            // Results are truncated to 16 bits as per output port width
            // Fix STX_VE_481: Assign sum/difference to a temporary wire before slicing
            // For 32-bit signed operands, the sum/difference can be 33 bits, so declare as [32:0]
            wire signed [32:0] temp_real_calc = ac_mult - bd_mult;
            wire signed [32:0] temp_imag_calc = ad_mult + bc_mult;
            
            output_z_real <= temp_real_calc[15:0];
            output_z_imag <= temp_imag_calc[15:0];
        end
    end

endmodule
