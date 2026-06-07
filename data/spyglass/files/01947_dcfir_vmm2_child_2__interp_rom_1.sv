// Helper module definition for interp_rom_1
module interp_rom_1 (
    input CLK, // Can be ignored for combinational ROM
    input rst, // Can be ignored for combinational ROM
    input CEB, // Assuming active-high Chip Enable (CE) based on usage context (CEB(flag) where flag implies data)
    input [9:0] Addr,
    output [19:0] Q
);

reg [19:0] rom_data [0:1023]; // 10-bit address means 1024 locations

initial begin
    integer i; // Declare integer loop variable outside for loop for Verilog-2001 compatibility
    // Initialize ROM data with some dummy values for linting.
    // In a real design, this would be loaded from a file or hardcoded.
    for (i = 0; i < 1024; i = i + 1) begin
        // Example: simple dummy data for 20-bit output
        // {10-bit real part, 10-bit imag part}
        // Replaced SystemVerilog casting '10'(...) with Verilog-2001 style bit-selection '(...)[9:0]'
        rom_data[i] = {((i * 3 + 7) % 1024)[9:0], ((i * 5 + 13) % 1024)[9:0]};
    end
end

reg [19:0] Q_reg;

always @(*) begin
    if (CEB) begin // Active high enable: if CEB is 1, enabled. (assuming CEB is actually CE)
        Q_reg = rom_data[Addr];
    end else begin
        Q_reg = 20'd0; // When disabled, output 0
    end
}

assign Q = Q_reg;

endmodule
