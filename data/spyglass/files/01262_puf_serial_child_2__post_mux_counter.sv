module post_mux_counter(
    output reg [22:0] counter_out, // Changed to reg
    output reg fin,                 // Changed to reg
    input enable_bit,
    input mux_input,
    input reset_signal
    );
    // Implemented a minimal counter logic to consume all inputs
    always @(posedge mux_input or posedge reset_signal) begin // Trigger on mux_input for counting, or reset
        if (reset_signal) begin
            counter_out <= 23'd0;
            fin <= 1'b0;
        end else if (enable_bit) begin // Only count if enabled
            counter_out <= counter_out + 1;
            // Dummy condition for fin: becomes high after a certain count
            fin <= (counter_out == 23'dFFFFF && enable_bit); 
        end
    end
endmodule
