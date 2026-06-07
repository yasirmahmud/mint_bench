module aes_main_MixColumn_AddRoundKey_ret_RAM_AUTO_1R1W (
    input clk,
    input reset,
    input [5-1:0] address0,
    input ce0,
    input we0,
    input [32-1:0] d0,
    output reg [32-1:0] q0,
    input [5-1:0] address1,
    input ce1,
    input we1,
    input [32-1:0] d1,
    output reg [32-1:0] q1
);

    parameter DataWidth = 32;
    parameter AddressRange = 32;
    parameter AddressWidth = 5;

    reg [DataWidth-1:0] mem[0:AddressRange-1];

    integer i;
    initial begin
        for (i = 0; i < AddressRange; i = i + 1) begin
            mem[i] = {DataWidth{1'b0}};
        end
    end

    // Port 0
    always @(posedge clk) begin
        if (ce0) begin
            if (we0) begin
                mem[address0] <= d0;
            end
            q0 <= mem[address0];
        end
    end

    // Port 1
    always @(posedge clk) begin
        if (ce1) begin
            if (we1) begin
                mem[address1] <= d1;
            end
            q1 <= mem[address1];
        end
    end

endmodule
