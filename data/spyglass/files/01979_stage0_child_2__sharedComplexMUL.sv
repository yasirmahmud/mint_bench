// Minimal definition for sharedComplexMUL to resolve ErrorAnalyzeBBox violation.
// This module assumes a pass-through of inputs with width adjustment,
// based on the "unity coefficients" and the output width specification,
// without implementing full complex multiply-accumulate logic.
// The inputs i_nX and i_mX are interpreted as complex numbers {real_part, imaginary_part},
// each part p_inputWidth bits wide. The imaginary part is expected to be zero from stage0.
// The outputs are sign-extended and concatenated to form the wider complex output.
module sharedComplexMUL #(parameter p_inputWidth = 8,
                           parameter p_PointPosition = 0
                          )
                          (
                           input CLK,
RST,
                           input signed [(2*p_inputWidth - 1) : 0] i_m1,
                           input signed [(2*p_inputWidth - 1) : 0] i_m2,
                           input signed [(2*p_inputWidth - 1) : 0] i_m3,
                           input signed [(2*p_inputWidth - 1) : 0] i_m4,
                           
                           input signed [(2*p_inputWidth - 1) : 0] i_n1,
                           input signed [(2*p_inputWidth - 1) : 0] i_n2,
                           input signed [(2*p_inputWidth - 1) : 0] i_n3,
                           input signed [(2*p_inputWidth - 1) : 0] i_n4,
                           
                           input [15 : 0] i_l1,
                           input [15 : 0] i_l2,
                           input [15 : 0] i_l3,
                           input [15 : 0] i_l4,
                           
                           output signed [(2*(2*p_inputWidth - p_PointPosition) + 1) : 0] o_r1_p,
                           output signed [(2*(2*p_inputWidth - p_PointPosition) + 1) : 0] o_r1_m,
                           output signed [(2*(2*p_inputWidth - p_PointPosition) + 1) : 0] o_r2_p,
                           output signed [(2*(2*p_inputWidth - p_PointPosition) + 1) : 0] o_r2_m,
                           output signed [(2*(2*p_inputWidth - p_PointPosition) + 1) : 0] o_r3_p,
                           output signed [(2*(2*p_inputWidth - p_PointPosition) + 1) : 0] o_r3_m,
                           output signed [(2*(2*p_inputWidth - p_PointPosition) + 1) : 0] o_r4_p,
                           output signed [(2*(2*p_inputWidth - p_PointPosition) + 1) : 0] o_r4_m
                          );
    
    // Calculate the width of each real/imag part of the output complex number
    localparam CPLX_PART_WIDTH = (2*p_inputWidth - p_PointPosition) + 1;
    
    // Extract real and imaginary parts from the input complex numbers
    // and sign-extend them to the CPLX_PART_WIDTH.
    // Since i_nX_imag is typically 0 from stage0, it will be sign-extended as zeros.

    // i_n1 / i_m1 processing
    wire signed [p_inputWidth-1 : 0] i_n1_real_val = i_n1[p_inputWidth-1 : 0];
    wire signed [p_inputWidth-1 : 0] i_n1_imag_val = i_n1[2*p_inputWidth-1 : p_inputWidth];
    wire signed [CPLX_PART_WIDTH-1 : 0] o_r1_p_real_ext = {{ (CPLX_PART_WIDTH - p_inputWidth){i_n1_real_val[p_inputWidth-1]} }, i_n1_real_val};
    wire signed [CPLX_PART_WIDTH-1 : 0] o_r1_p_imag_ext = {{ (CPLX_PART_WIDTH - p_inputWidth){i_n1_imag_val[p_inputWidth-1]} }, i_n1_imag_val};
    assign o_r1_p = {o_r1_p_real_ext, o_r1_p_imag_ext};

    wire signed [p_inputWidth-1 : 0] i_m1_real_val = i_m1[p_inputWidth-1 : 0];
    wire signed [p_inputWidth-1 : 0] i_m1_imag_val = i_m1[2*p_inputWidth-1 : p_inputWidth];
    wire signed [CPLX_PART_WIDTH-1 : 0] o_r1_m_real_ext = {{ (CPLX_PART_WIDTH - p_inputWidth){i_m1_real_val[p_inputWidth-1]} }, i_m1_real_val};
    wire signed [CPLX_PART_WIDTH-1 : 0] o_r1_m_imag_ext = {{ (CPLX_PART_WIDTH - p_inputWidth){i_m1_imag_val[p_inputWidth-1]} }, i_m1_imag_val};
    assign o_r1_m = {o_r1_m_real_ext, o_r1_m_imag_ext};

    // i_n2 / i_m2 processing
    wire signed [p_inputWidth-1 : 0] i_n2_real_val = i_n2[p_inputWidth-1 : 0];
    wire signed [p_inputWidth-1 : 0] i_n2_imag_val = i_n2[2*p_inputWidth-1 : p_inputWidth];
    wire signed [CPLX_PART_WIDTH-1 : 0] o_r2_p_real_ext = {{ (CPLX_PART_WIDTH - p_inputWidth){i_n2_real_val[p_inputWidth-1]} }, i_n2_real_val};
    wire signed [CPLX_PART_WIDTH-1 : 0] o_r2_p_imag_ext = {{ (CPLX_PART_WIDTH - p_inputWidth){i_n2_imag_val[p_inputWidth-1]} }, i_n2_imag_val};
    assign o_r2_p = {o_r2_p_real_ext, o_r2_p_imag_ext};

    wire signed [p_inputWidth-1 : 0] i_m2_real_val = i_m2[p_inputWidth-1 : 0];
    wire signed [p_inputWidth-1 : 0] i_m2_imag_val = i_m2[2*p_inputWidth-1 : p_inputWidth];
    wire signed [CPLX_PART_WIDTH-1 : 0] o_r2_m_real_ext = {{ (CPLX_PART_WIDTH - p_inputWidth){i_m2_real_val[p_inputWidth-1]} }, i_m2_real_val};
    wire signed [CPLX_PART_WIDTH-1 : 0] o_r2_m_imag_ext = {{ (CPLX_PART_WIDTH - p_inputWidth){i_m2_imag_val[p_inputWidth-1]} }, i_m2_imag_val};
    assign o_r2_m = {o_r2_m_real_ext, o_r2_m_imag_ext};

    // i_n3 / i_m3 processing
    wire signed [p_inputWidth-1 : 0] i_n3_real_val = i_n3[p_inputWidth-1 : 0];
    wire signed [p_inputWidth-1 : 0] i_n3_imag_val = i_n3[2*p_inputWidth-1 : p_inputWidth];
    wire signed [CPLX_PART_WIDTH-1 : 0] o_r3_p_real_ext = {{ (CPLX_PART_WIDTH - p_inputWidth){i_n3_real_val[p_inputWidth-1]} }, i_n3_real_val};
    wire signed [CPLX_PART_WIDTH-1 : 0] o_r3_p_imag_ext = {{ (CPLX_PART_WIDTH - p_inputWidth){i_n3_imag_val[p_inputWidth-1]} }, i_n3_imag_val};
    assign o_r3_p = {o_r3_p_real_ext, o_r3_p_imag_ext};

    wire signed [p_inputWidth-1 : 0] i_m3_real_val = i_m3[p_inputWidth-1 : 0];
    wire signed [p_inputWidth-1 : 0] i_m3_imag_val = i_m3[2*p_inputWidth-1 : p_inputWidth];
    wire signed [CPLX_PART_WIDTH-1 : 0] o_r3_m_real_ext = {{ (CPLX_PART_WIDTH - p_inputWidth){i_m3_real_val[p_inputWidth-1]} }, i_m3_real_val};
    wire signed [CPLX_PART_WIDTH-1 : 0] o_r3_m_imag_ext = {{ (CPLX_PART_WIDTH - p_inputWidth){i_m3_imag_val[p_inputWidth-1]} }, i_m3_imag_val};
    assign o_r3_m = {o_r3_m_real_ext, o_r3_m_imag_ext};

    // i_n4 / i_m4 processing
    wire signed [p_inputWidth-1 : 0] i_n4_real_val = i_n4[p_inputWidth-1 : 0];
    wire signed [p_inputWidth-1 : 0] i_n4_imag_val = i_n4[2*p_inputWidth-1 : p_inputWidth];
    wire signed [CPLX_PART_WIDTH-1 : 0] o_r4_p_real_ext = {{ (CPLX_PART_WIDTH - p_inputWidth){i_n4_real_val[p_inputWidth-1]} }, i_n4_real_val};
    wire signed [CPLX_PART_WIDTH-1 : 0] o_r4_p_imag_ext = {{ (CPLX_PART_WIDTH - p_inputWidth){i_n4_imag_val[p_inputWidth-1]} }, i_n4_imag_val};
    assign o_r4_p = {o_r4_p_real_ext, o_r4_p_imag_ext};

    wire signed [p_inputWidth-1 : 0] i_m4_real_val = i_m4[p_inputWidth-1 : 0];
    wire signed [p_inputWidth-1 : 0] i_m4_imag_val = i_m4[2*p_inputWidth-1 : p_inputWidth];
    wire signed [CPLX_PART_WIDTH-1 : 0] o_r4_m_real_ext = {{ (CPLX_PART_WIDTH - p_inputWidth){i_m4_real_val[p_inputWidth-1]} }, i_m4_real_val};
    wire signed [CPLX_PART_WIDTH-1 : 0] o_r4_m_imag_ext = {{ (CPLX_PART_WIDTH - p_inputWidth){i_m4_imag_val[p_inputWidth-1]} }, i_m4_imag_val};
    assign o_r4_m = {o_r4_m_real_ext, o_r4_m_imag_ext};

endmodule
