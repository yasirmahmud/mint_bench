module convMod #(
    parameter lenOfInput=8,
    parameter lenOfOutput=25
) (
    input signed [lenOfInput-1:0] in00, in01, in02, in03,
    input signed [lenOfInput-1:0] in10, in11, in12, in13,
    input signed [lenOfInput-1:0] in20, in21, in22, in23,
    input signed [lenOfInput-1:0] in30, in31, in32, in33,
    input signed [lenOfInput-1:0] k00, k01, k02, k03,
    input signed [lenOfInput-1:0] k10, k11, k12, k13,
    input signed [lenOfInput-1:0] k20, k21, k22, k23,
    input signed [lenOfInput-1:0] k30, k31, k32, k33,
    output signed [lenOfOutput-1:0] convOut
);
    // This is a dummy convolution module to satisfy the synthesis tool for 'convMod' instantiation.
    // In a real design, this would be a full Multiply-Accumulate (MAC) array or more complex logic.
    // The logic here is a simple sum of products, matching the expected output bit width.
    assign convOut = (k00 * in00) + (k01 * in01) + (k02 * in02) + (k03 * in03) +
                     (k10 * in10) + (k11 * in11) + (k12 * in12) + (k13 * in13) +
                     (k20 * in20) + (k21 * in21) + (k22 * in22) + (k23 * in23) +
                     (k30 * in30) + (k31 * in31) + (k32 * in32) + (k33 * in33);
endmodule
