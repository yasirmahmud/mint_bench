module blake2 #(
    parameter NN = 32,
    parameter NN_b = 8'b0010_0000
) (
    input          clk,
    input          nreset,
    input          valid_i,
    input  [511:0] d_i,
    output         valid_o,
    output [255:0] h_o
);
    // Stub module for 'blake2' to resolve SpyGlass ErrorAnalyzeBBox violation.
    // The actual functional implementation of blake2 is expected to be provided externally.
    // Outputs are driven to dummy values to prevent floating signals in simulation/synthesis.
    assign valid_o = 1'b0;
    assign h_o     = {256{1'b0}};
endmodule
