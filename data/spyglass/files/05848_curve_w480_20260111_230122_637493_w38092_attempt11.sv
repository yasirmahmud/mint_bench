module curve_w480_20260111_230122_637493_w38092_attempt11 (
    input wire [7:0] data_in,
    output reg [7:0] data_out
);

    // W480: Loop index 'loop_idx' is not of type integer.
    // Declaring 'loop_idx' as 'reg' instead of 'integer' will trigger this violation.
    reg [4:0] loop_idx;

    always @(*) begin
        reg [7:0] local_accumulator; // Temporary variable for accumulation
        local_accumulator = 8'h00;   // Initialize the accumulator

        // The 'for' loop uses 'loop_idx', which is a 'reg' type, violating W480.
        for (loop_idx = 5'd0; loop_idx < 5'd10; loop_idx = loop_idx + 5'd1) begin
            // Simple combinational logic using the loop index.
            // Access a bit from data_in using a truncated part of loop_idx
            local_accumulator = local_accumulator + data_in[loop_idx[2:0]];
        end

        // Assign the final accumulated value to the module output
        data_out = local_accumulator;
    end

endmodule
