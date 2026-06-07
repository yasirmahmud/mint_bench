module curve_wrn_1021_20260111_220720_686432_w32456_attempt12 (
    input wire clk,
    input wire rst,
    input wire [7:0] in_data,
    output reg [7:0] out_data
);

    // Declare a 4-element array, valid indices are [0] to [3]
    reg [7:0] my_array_storage [3:0];

    // Synthesizable block to handle inputs/outputs and ensure registers are used.
    // This ensures no unused signal warnings for clk, rst, in_data, out_data, or my_array_storage[0].
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            my_array_storage[0] <= 8'h00; // Valid access, initializes an element
            out_data <= 8'h00;
        end else begin
            my_array_storage[0] <= in_data; // Valid access, uses in_data
            out_data <= my_array_storage[0]; // Uses my_array_storage[0] and drives out_data
        end
    end

    // The WRN_1021 violations are placed in an initial block.
    // This makes the out-of-bounds accesses unsynthesizable,
    // which should prevent SYNTH_5255 (SynthesisError) while still allowing
    // linting tools to flag WRN_1021 (Warning).
    initial begin
        // First WRN_1021 violation: Array index 4 is out of bounds for the declared range [3:0]
        my_array_storage[4] = 8'hAA;

        // Second WRN_1021 violation: Array index 5 is out of bounds for the declared range [3:0]
        // Using a different out-of-bounds index ensures two distinct WRN_1021 violations
        // without generating multiple driver warnings.
        my_array_storage[5] = 8'hBB;
    end

endmodule
