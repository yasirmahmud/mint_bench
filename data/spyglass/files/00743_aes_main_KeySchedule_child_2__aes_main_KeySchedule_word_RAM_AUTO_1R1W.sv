module aes_main_KeySchedule_word_RAM_AUTO_1R1W #(
    parameter DataWidth = 32,
    parameter AddressRange = 480,
    parameter AddressWidth = 9
) (
    input clk,
    // input reset, // Removed: unused input, resolves W240
    input [AddressWidth-1:0] address0,
    input ce0,
    input we0,
    input [DataWidth-1:0] d0,
    output [DataWidth-1:0] q0,
    input [AddressWidth-1:0] address1,
    input ce1,
    output [DataWidth-1:0] q1
);

reg [DataWidth-1:0] ram[0:AddressRange-1];
reg [DataWidth-1:0] q0_reg;
reg [DataWidth-1:0] q1_reg;

assign q0 = q0_reg;
assign q1 = q1_reg;

always @(posedge clk) begin
    if (ce0) begin
        if (we0) begin
            ram[address0] <= d0; // Synchronous write
        end
        // Synchronous read for q0. If write enabled to same address, output new data.
        q0_reg <= (we0) ? d0 : ram[address0]; 
    end
    if (ce1) begin
        // Synchronous read for q1. If another port is writing to address1, output new data.
        q1_reg <= (ce0 && we0 && address1 == address0) ? d0 : ram[address1];
    end
end

endmodule
