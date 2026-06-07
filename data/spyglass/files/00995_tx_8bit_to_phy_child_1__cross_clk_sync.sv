// Definition for cross_clk_sync to resolve black-box violation (ELAB_3519)
// This implements a generic N-flop synchronizer.
module cross_clk_sync #(
    parameter LAT = 2 // Latency (number of flops)
) (
    input                 clk,
    input                 rst_n,
    input                 d,   // Input signal to synchronize
    output                q    // Synchronized output signal
);

reg [LAT-1:0] sync_regs; // Array of registers for latency stages

always @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
        sync_regs <= {LAT{1'b0}}; // Reset all flops
    end else begin
        sync_regs <= {sync_regs[LAT-2:0], d}; // Shift in d, shift out through chain
    end
end

assign q = sync_regs[LAT-1]; // Output is from the last flop

endmodule
