module curve_wrn_1021_20260110_212639_attempt1 (
    input wire clk,
    input wire enable
);

    // Declare a register array 'my_array' with 10 elements, indexed from 0 to 9.
    reg [7:0] my_array [9:0];

    always @(posedge clk) begin
        if (enable) begin
            // This assignment attempts to write to index 10 of 'my_array'.
            // Since 'my_array' is declared with indices [9:0], index 10 is out-of-bounds.
            // This line will trigger exactly one WRN_1021 violation.
            my_array[10] <= 8'hFF;

            // Assign to a valid index to ensure the array itself is considered used,
            // preventing potential 'unused signal' warnings for the entire array.
            my_array[0] <= 8'd0;
        end
    end

endmodule
