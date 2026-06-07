module puf_serial(
    input [31:0] enables,
    input [7:0] challenge,
    output [7:0] response,
    output done,
    input clk,
    input computer_ack
    );
    // Black-box module definition to resolve SpyGlass ErrorAnalyzeBBox
    // Actual implementation is assumed to be provided separately.
endmodule
