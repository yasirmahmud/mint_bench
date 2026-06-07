module aes_main_MixColumn_AddRoundKey_MixColumn_AddRoundKey_word_ROM_AUTO_1R (
    input clk,
    input reset,
    input [9-1:0] address0,
    input ce0,
    output reg [32-1:0] q0,
    input [9-1:0] address1,
    input ce1,
    output reg [32-1:0] q1
);

    parameter DataWidth = 32;
    parameter AddressRange = 480;
    parameter AddressWidth = 9;

    reg [DataWidth-1:0] mem[0:AddressRange-1];

    integer i;
    initial begin
        for (i = 0; i < AddressRange; i = i + 1) begin
            mem[i] = {DataWidth{1'b0}};
        end
    end

    always @(posedge clk) begin
        if (ce0) begin
            q0 <= mem[address0];
        end
    end

    always @(posedge clk) begin
        if (ce1) begin
            q1 <= mem[address1];
        end
    end

endmodule
