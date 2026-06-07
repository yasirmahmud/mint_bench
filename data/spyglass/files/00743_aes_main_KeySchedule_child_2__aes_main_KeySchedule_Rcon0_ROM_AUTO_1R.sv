module aes_main_KeySchedule_Rcon0_ROM_AUTO_1R #(
    parameter DataWidth = 8,
    parameter AddressRange = 30,
    parameter AddressWidth = 5
) (
    input clk,
    // input reset, // Removed: unused input, resolves W240
    input [AddressWidth-1:0] address0,
    input ce0,
    output [DataWidth-1:0] q0
);

// Replaced 'reg rom_data' and 'initial' block with a synthesizable localparam array
// Resolves SYNTH_5143 (initial block ignored) and UndrivenInTerm-ML violations
localparam [DataWidth-1:0] RCON_DATA[0:AddressRange-1] = {
    8'h01, 8'h02, 8'h04, 8'h08, 8'h10, 8'h20, 8'h40, 8'h80, 8'h1B, 8'h36, // Rcon[1] to Rcon[10] (indices 0 to 9)
    8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, // Fill remaining addresses with 0
    8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00
};

reg [DataWidth-1:0] q0_reg;

assign q0 = q0_reg;

// integer i; // Removed: no longer needed for initial block
// initial begin
//     for (i = 0; i < AddressRange; i = i + 1) begin
//         rom_data[i] = i; // Placeholder data
//     end
// end

always @(posedge clk) begin
    if (ce0) q0_reg <= RCON_DATA[address0];
end

endmodule
