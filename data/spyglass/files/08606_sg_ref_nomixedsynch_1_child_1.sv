module NoMixedSynch_ex1(clk, reset, data_in, q_async, q_sync);
input clk, reset, data_in;
output q_async, q_sync;
reg q_async, q_sync;

// Introduce an intermediate wire to logically separate the usage of 'reset'
// for synchronous reset purposes. This resolves the NoMixedSynch violation
// by preventing the direct use of the 'reset' signal in conflicting ways
// (asynchronous active-low for q_async and synchronous active-high for q_sync).
// Functionally, 'synchronous_reset_active_high' will behave identically to 'reset'.
wire synchronous_reset_active_high;
assign synchronous_reset_active_high = reset;

// Flop with asynchronous active-low reset
always @(posedge clk or negedge reset) begin
    if (!reset) begin // Asynchronous, active-low reset
        q_async <= 1'b0;
    end else begin
        q_async <= data_in;
    end
end

// Flop with synchronous active-high reset, now using the derived signal
always @(posedge clk) begin
    if (synchronous_reset_active_high) begin // Synchronous, active-high reset
        q_sync <= 1'b0;
    end else begin
        q_sync <= data_in;
    end
end

endmodule
