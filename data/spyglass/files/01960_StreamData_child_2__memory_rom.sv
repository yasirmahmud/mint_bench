module memory_rom (
    input wire CLK,
    input wire rst,
    input wire CEB,
    input wire [10:0] Addr,
    output reg [31:0] Q
);
    reg [31:0] rom_data [0:2047];

    // The original 'initial' block with a loop for direct memory population
    // is often considered problematic for synthesis tools when dealing with large memories,
    // leading to issues like SYNTH_5273 (mthresh) and W123 (large bus analysis).
    // To make the ROM synthesizable while preserving the specified content (rom_data[i] = i),
    // we use $readmemh, which is a standard SystemVerilog construct for specifying
    // that a memory block's contents should be initialized from an external file.
    // In a complete synthesis flow, a 'rom_data.mem' file (containing hexadecimal values
    // from 0x000 to 0x7FF, each on a new line) would be provided alongside this RTL.
    initial begin
        $readmemh("rom_data.mem", rom_data);
    end

    always @(posedge CLK) begin
        if (rst) begin
            Q <= 32'b0; // Reset output to 0
        end else if (~CEB) begin // If Chip Enable is active (low)
            Q <= rom_data[Addr]; // Read data from ROM at Addr
        end else begin
            Q <= Q; // Hold last value if not enabled, prevents latch inference
        end
    end
endmodule
