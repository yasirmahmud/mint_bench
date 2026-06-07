module curve_w480_20260111_230122_637493_w38092_attempt12 (
    input wire [7:0] data_in,
    output reg [7:0] data_out
);

    // W480: Loop index 'loop_idx' is not of type integer.
    // Declaring 'loop_idx' as 'reg' instead of 'integer' will trigger this violation.
    reg [4:0] loop_idx;

    always @(*) begin
        integer temp_sum; // Declared as integer to avoid W415a for accumulation
        temp_sum = 0;     // Initialize the integer accumulator

        // The 'for' loop uses 'loop_idx', which is a 'reg' type, violating W480.
        // The loop runs from 0 to 14 (15 iterations).
        for (loop_idx = 5'd0; loop_idx < 5'd15; loop_idx = loop_idx + 5'd1) begin
            // Simple combinational logic inside the loop:
            // Increment temp_sum by 1 in each iteration.
            temp_sum = temp_sum + 1;
        end

        // Assign the final accumulated value (truncated to 8 bits) and add data_in.
        // This ensures data_out is driven and data_in is used.
        data_out = temp_sum[7:0] + data_in;
    end

endmodule
