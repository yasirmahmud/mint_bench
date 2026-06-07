module curve_w480_20260111_194937_112803_w53504_attempt9 (
    input wire [7:0] data_in,
    output reg [3:0] processed_count
);

    // W480: Loop index 'idx' is declared as 'reg' instead of 'integer'.
    // This declaration directly triggers the target rule.
    reg [3:0] idx; // Loop index 'idx' is declared as 'reg'

    always @(*) begin
        // Use a local integer variable for accumulation to avoid W415a and
        // ensure 'processed_count' is assigned only once at the end of the block.
        integer temp_count; 
        temp_count = 0; // Initialize local accumulator

        // The 'for' loop uses 'idx' which is a 'reg' type, triggering W480.
        for (idx = 4'd0; idx < 4'd8; idx = idx + 4'd1) begin
            // Simple combinational logic inside the loop.
            // Accumulate into the local 'integer' variable.
            if (data_in[idx]) begin
                temp_count = temp_count + 1; 
            end
        end
        
        // Assign the final accumulated value to the module output 'processed_count' once.
        processed_count = temp_count; 
    end

endmodule
