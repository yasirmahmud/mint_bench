module curve_w480_20260111_114952_attempt2 (
    input [7:0] data_in,
    output reg [3:0] count_ones_out
);

    // Function to count ones, uses a non-integer loop index
    // The loop index 'j' is declared as 'reg' instead of 'integer', triggering W480.
    function [3:0] count_ones;
        input [7:0] data;
        reg [2:0] j; // W480 violation: Loop index 'j' is not of type integer
        reg [3:0] temp_count; // Local temporary variable within the function

        begin
            temp_count = 4'h0; // Initialize local counter
            for (j = 0; j < 8; j = j + 1) begin // Loop with non-integer index 'j'
                if (data[j]) begin
                    temp_count = temp_count + 1; // Accumulate count within the function
                end
            end
            count_ones = temp_count; // Assign the final count to the function's return value
        end
    endfunction

    // The output reg is assigned only once in this always block, avoiding W415a.
    always @(*) begin
        count_ones_out = count_ones(data_in);
    end

endmodule
