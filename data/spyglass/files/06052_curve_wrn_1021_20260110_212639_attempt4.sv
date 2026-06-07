module curve_wrn_1021_20260110_212639_attempt4 (
    input wire clk,
    input wire enable,
    input wire [15:0] in_data,
    output reg [15:0] out_data
);

    // Declare a reg array 'my_ram' with 8 elements, each 16-bit wide.
    // Valid indices are from 0 to 7.
    reg [15:0] my_ram [7:0];

    always @(posedge clk) begin
        if (enable) begin
            // Synthesizable assignments to valid array elements to ensure 'my_ram' is used.
            my_ram[0] <= in_data;
            my_ram[1] <= {1'b0, in_data[15:1]}; // Example logic

            // --- Trigger WRN_1021 violations (2 occurrences) ---

            // First occurrence: Attempt to write to index 8, which is out of bounds for [7:0].
            my_ram[8] <= 16'hAAAA; // Array index 8 is out-of-bounds ([7:0])

            // Second occurrence: Attempt to write to index 9, also out of bounds for [7:0].
            my_ram[9] <= 16'hBBBB; // Array index 9 is out-of-bounds ([7:0])

            // Assign a valid array element to the module's output to ensure 'my_ram' is read.
            out_data <= my_ram[0];
        end else begin
            // Default assignments to prevent latches and ensure specified 'reg' signals are driven.
            my_ram[0] <= 16'h0000;
            my_ram[1] <= 16'h0000;
            out_data <= 16'h0000;
        end
    end

endmodule
