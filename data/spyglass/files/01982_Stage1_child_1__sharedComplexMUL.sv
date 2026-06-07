module sharedComplexMUL #(
    parameter p_inputWidth = 9,
    parameter p_PointPosition = 0,
    parameter p_widdleBits = 18
) (
    input CLK,
    input RST,

    input signed [2*p_inputWidth - 1 : 0] i_m1,
    input signed [2*p_inputWidth - 1 : 0] i_m2,
    input signed [2*p_inputWidth - 1 : 0] i_m3,
    input signed [2*p_inputWidth - 1 : 0] i_m4,

    input signed [2*p_inputWidth - 1 : 0] i_n1,
    input signed [2*p_inputWidth - 1 : 0] i_n2,
    input signed [2*p_inputWidth - 1 : 0] i_n3,
    input signed [2*p_inputWidth - 1 : 0] i_n4,

    input signed [p_widdleBits - 1 : 0] i_l1,
    input signed [p_widdleBits - 1 : 0] i_l2,
    input signed [p_widdleBits - 1 : 0] i_l3,
    input signed [p_widdleBits - 1 : 0] i_l4,

    output signed [2 * (2 * p_inputWidth - p_PointPosition) + 1 : 0] o_r1_p,
    output signed [2 * (2 * p_inputWidth - p_PointPosition) + 1 : 0] o_r1_m,
    output signed [2 * (2 * p_inputWidth - p_PointPosition) + 1 : 0] o_r2_p,
    output signed [2 * (2 * p_inputWidth - p_PointPosition) + 1 : 0] o_r2_m,
    output signed [2 * (2 * p_inputWidth - p_PointPosition) + 1 : 0] o_r3_p,
    output signed [2 * (2 * p_inputWidth - p_PointPosition) + 1 : 0] o_r3_m,
    output signed [2 * (2 * p_inputWidth - p_PointPosition) + 1 : 0] o_r4_p,
    output signed signed [2 * (2 * p_inputWidth - p_PointPosition) + 1 : 0] o_r4_m
);

    // Local parameter for output width for clarity
    localparam P_OUTPUT_COMPLEX_WIDTH = 2 * (2 * p_inputWidth - p_PointPosition) + 2;

    // Dummy assignments for linting purposes to avoid undriven signals.
    // Actual complex multiplication logic would go here in a full implementation.
    assign o_r1_p = {P_OUTPUT_COMPLEX_WIDTH{1'b0}};
    assign o_r1_m = {P_OUTPUT_COMPLEX_WIDTH{1'b0}};
    assign o_r2_p = {P_OUTPUT_COMPLEX_WIDTH{1'b0}};
    assign o_r2_m = {P_OUTPUT_COMPLEX_WIDTH{1'b0}};
    assign o_r3_p = {P_OUTPUT_COMPLEX_WIDTH{1'b0}};
    assign o_r3_m = {P_OUTPUT_COMPLEX_WIDTH{1'b0}};
    assign o_r4_p = {P_OUTPUT_COMPLEX_WIDTH{1'b0}};
    assign o_r4_m = {P_OUTPUT_COMPLEX_WIDTH{1'b0}};

endmodule
