module curve_w480_20260111_194937_112803_w53504_attempt7 (
    input wire clk,
    input wire rst_n,
    output reg [7:0] counter_out
);

// W480: Loop index 'loop_idx' is declared as 'reg' instead of 'integer'.
reg [3:0] loop_idx; 

reg [7:0] temp_accumulator; // Temporary variable for accumulation within the cycle

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        counter_out <= 8'h00;
        temp_accumulator <= 8'h00; // Reset temp_accumulator on reset
    end else begin
        // Initialize local accumulator for the current clock cycle's calculation
        temp_accumulator = 8'h00;
        
        // The loop index 'loop_idx' is of type 'reg' instead of 'integer',
        // which triggers the W480 violation.
        // The accumulation uses blocking assignments to a temporary variable,
        // avoiding multiple assignments to the output register (W415a).
        for (loop_idx = 4'd0; loop_idx < 4'd5; loop_idx = loop_idx + 4'd1) begin
            temp_accumulator = temp_accumulator + 8'd1;
        end
        
        // Assign the final accumulated value to the output register once per cycle
        counter_out <= temp_accumulator;
    end
end

endmodule
