module curve_wrn_1021_20260110_212639_attempt3 (
    input wire clk,
    input wire enable,
    output reg [7:0] out_data
);

    // Declare a reg array 'data_array' with 10 elements.
    // Valid indices are from 0 to 9.
    reg [7:0] data_array [9:0];

    always @(posedge clk) begin
        if (enable) begin
            // Synthesizable assignments to valid array elements.
            // This ensures 'data_array' is considered both written and read,
            // preventing W123 (variable not set) or W528 (variable set but not read) for the array itself.
            data_array[0] <= 8'h01;
            data_array[1] <= 8'h02;

            // --- Trigger WRN_1021 violations ---

            // First occurrence: Attempt to write to index 10, which is out of bounds for [9:0].
            // This directly matches the example context's array index and expected violation message.
            data_array[10] <= 8'hAA; // Array index 10 is out-of-bounds ([9:0])

            // Second occurrence: Attempt to write to index 12, also out of bounds.
            // This provides the second required violation and makes the example distinct from previous attempts
            // that might have used the same out-of-bounds index twice.
            data_array[12] <= 8'hBB; // Array index 12 is out-of-bounds ([9:0])

            // Assign a valid array element to the module's output.
            // This ensures 'data_array' is read within a synthesizable context,
            // preventing any unused variable warnings for 'data_array'.
            // 'out_data' is an output, so it is assumed to be read externally.
            out_data <= data_array[0];
        end else begin
            // Default assignments to prevent latches and ensure all 'reg' signals are driven.
            data_array[0] <= 8'h00;
            data_array[1] <= 8'h00;
            // No out-of-bounds accesses in the else branch to keep the violation count precise.
            out_data <= 8'h00;
        end
    end

endmodule
