module curve_wrn_1021_20260110_212639_attempt2 ();

    // Declare a localparam for array size to explicitly highlight the off-by-one error.
    // The array will have 10 elements, indexed from 0 to 9.
    localparam ARRAY_COUNT = 10; // ARRAY_COUNT = 10
    reg [7:0] my_array [ARRAY_COUNT-1:0]; // Permissible range is [9:0]

    initial begin
        // This assignment attempts to write to index ARRAY_COUNT (which is 10) of 'my_array'.
        // Since 'my_array' is declared with indices [9:0], index 10 is out-of-bounds.
        // This line will trigger the first WRN_1021 violation.
        my_array[ARRAY_COUNT] = 8'hFF; // Access index 10

        // This line will trigger the second WRN_1021 violation, fulfilling the 'Total occurrences: 2' requirement.
        my_array[ARRAY_COUNT] = 8'hAA; // Access index 10 again
    end

    // To prevent 'W528: Variable 'my_array' set but not read.' reported in the previous attempt,
    // read a valid element from the array. This ensures the array is considered 'used'.
    wire [7:0] dummy_read_val;
    assign dummy_read_val = my_array[0]; // Access a valid index within the range [9:0]

    // The 'dummy_read_val' wire itself might be reported as an unused signal (e.g., W529).
    // However, this is distinct from WRN_1021 and W528 (which was specifically for 'my_array').
    // This approach avoids synthesis errors (SYNTH_5255, ErrorAnalyzeBBox) by using an initial block,
    // which is not part of synthesizable logic and thus less likely to cause synthesis failures.

endmodule
