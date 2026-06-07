module curve_wrn_1021_20260110_212639_attempt5 (
    input wire clk,
    input wire reset_n, // Active low reset
    input wire [3:0] data_in,
    output reg [3:0] data_out
);

    // Declare a reg array 'storage_array' with 7 elements, each 4-bit wide.
    // Valid indices are from 0 to 6.
    reg [3:0] storage_array [6:0];

    // Placeholder register to use data_in and prevent unused signal warnings
    reg [3:0] internal_reg;

    always @(posedge clk) begin
        if (!reset_n) begin // Active low reset logic
            storage_array[0] <= 4'b0;
            storage_array[1] <= 4'b0;
            internal_reg <= 4'b0;
            data_out <= 4'b0;
        end else begin
            // Synthesizable assignments to valid array elements to ensure 'storage_array' is used.
            storage_array[0] <= data_in;
            storage_array[1] <= internal_reg + 1; // Example logic
            internal_reg <= data_in; // Use data_in to prevent unused input warnings

            // --- Trigger WRN_1021 violations (2 occurrences) ---

            // First occurrence: Attempt to write to index 7, which is out of bounds for [6:0].
            storage_array[7] <= 4'hA; // Array index 7 is out-of-bounds ([6:0])

            // Second occurrence: Attempt to write to index 8, also out of bounds for [6:0].
            storage_array[8] <= 4'hB; // Array index 8 is out-of-bounds ([6:0])

            // Assign a valid array element to the module's output to ensure 'storage_array' is read
            // and data_out is always driven.
            data_out <= storage_array[0];
        end
    end

endmodule
