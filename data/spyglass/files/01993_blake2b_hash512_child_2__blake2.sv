module blake2 #(
    parameter NN = 64,
    parameter NN_b = 8'b0100_0000
) (
    input clk,
    input nreset,
    input valid_i,
    input [1023:0] d_i,
    output valid_o,
    output [511:0] h_o
);
    // This is a placeholder module to resolve the SpyGlass black-box violation.
    // In a real design, the actual implementation of the blake2 hash function would be here.
    // For linting purposes, an empty module with the correct interface is sufficient.
    assign h_o = '0;
    assign valid_o = 1'b0;
endmodule
