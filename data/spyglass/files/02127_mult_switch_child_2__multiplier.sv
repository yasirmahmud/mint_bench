module multiplier (
    input clk,
    input [15:0] A,
    input [15:0] B,
    output [15:0] O
);
    // To preserve the functional behavior, the multiplier output must be combinational
    // because the 'mult_switch' module's 'o_valid' signal asserts in the same cycle
    // that its inputs A and B become valid. A synchronous output would introduce
    // a one-cycle latency, changing the design's behavior.
    // The 'clk' input is present in the port list as inferred from instantiation,
    // but it is not used for internal registration to maintain combinational output.
    wire [31:0] product_full;
    assign product_full = A * B;
    assign O = product_full[31:16];
endmodule
