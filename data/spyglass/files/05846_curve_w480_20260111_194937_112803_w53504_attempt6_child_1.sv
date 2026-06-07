module curve_w480_20260111_194937_112803_w53504_attempt6 (
    input wire clk,
    input wire rst_n,
    output reg [7:0] counter_out
);

integer loop_idx; // Changed from 'reg [3:0]' to 'integer' to resolve W480
reg [7:0] next_counter_out; // Temporary variable to resolve W415a

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        counter_out <= 8'h00;
    end else begin
        // Initialize the temporary variable with the current counter_out value.
        // The for loop will then accumulate increments into next_counter_out.
        next_counter_out = counter_out; 
        
        // The loop index 'loop_idx' is now of type 'integer', resolving W480.
        // The accumulation is done into a local variable 'next_counter_out'
        // using blocking assignments to ensure correct sequential sum within the cycle.
        for (loop_idx = 0; loop_idx < 5; loop_idx = loop_idx + 1) begin
            next_counter_out = next_counter_out + 8'd1; 
        end
        
        // 'counter_out' is assigned only once per clock cycle using a non-blocking assignment,
        // resolving W415a by updating the register with the final accumulated value.
        counter_out <= next_counter_out;
    end
end

endmodule
