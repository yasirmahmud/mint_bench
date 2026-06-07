module curve_w480_20260111_114952_attempt4 (
    input clk,
    input rst_n,
    input [3:0] data_in,
    output reg [2:0] count_out
);

    // W480 violation: Loop index 'i' is not of type integer.
    // 'i' is declared as a 'reg' type (a bit vector), not an 'integer' type.
    reg [1:0] i; 

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count_out <= 3'h0;
        end else begin
            // Initialize count_out at the beginning of the active clock cycle
            // This helps ensure a clean reset path for the accumulator.
            count_out <= 3'h0;

            // This for-loop uses a non-integer loop index 'i', which triggers W480.
            // The loop iterates a small, fixed number of times (4 iterations) to avoid
            // 'loop exceeds max. allowable limit' (SYNTH_5230) errors.
            // Non-blocking assignments are used within this sequential block to properly model
            // an accumulator and avoid multiple-driver warnings (W415a) for 'count_out'.
            for (i = 0; i < 4; i = i + 1) begin
                if (data_in[i]) begin
                    count_out <= count_out + 1;
                end
            end
        end
    end

endmodule
