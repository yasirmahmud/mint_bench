module aes_main_MixColumn_AddRoundKey_ret_RAM_AUTO_1R1W #(
    parameter DataWidth = 32,
    parameter AddressRange = 32,
    parameter AddressWidth = 5
) (
    input clk,
    input reset,
    input [AddressWidth-1:0] address0,
    input ce0,
    input we0,
    input [DataWidth-1:0] d0,
    output [DataWidth-1:0] q0,
    input [AddressWidth-1:0] address1,
    input ce1,
    input we1,
    input [DataWidth-1:0] d1,
    output [DataWidth-1:0] q1
);
    // Dummy implementation for linting, actual memory behavior defined elsewhere.
    // Fix W240: Inputs declared but not read.
    wire unused_clk = clk;
    wire unused_reset = reset;
    wire [AddressWidth-1:0] unused_address0 = address0;
    wire unused_ce0 = ce0;
    wire unused_we0 = we0;
    wire [DataWidth-1:0] unused_d0 = d0;
    wire [AddressWidth-1:0] unused_address1 = address1;
    wire unused_ce1 = ce1;
    wire unused_we1 = we1;
    wire [DataWidth-1:0] unused_d1 = d1;

    assign q0 = {DataWidth{1'b0}};
    assign q1 = {DataWidth{1'b0}};
endmodule
