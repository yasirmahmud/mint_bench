module curve_w502_20260111_195500_448650_w37940_attempt10 (
    input wire        enable_sig,
    input wire [3:0]  data_in,
    output reg [3:0]  latch_output
);

// Target rule: W502 - The signal/variable 'iv_mux_out' is modified inside always block
// This example demonstrates a common pattern where a signal is explicitly
// assigned to itself within a combinational always block, typically to describe
// a transparent latch's hold behavior. This explicit self-assignment is
// what the W502 rule is designed to flag.
// This example uses a 4-bit data path and specific names to be distinct.

reg [3:0] my_latch_reg; // Internal signal that will trigger the violation

always @(enable_sig or data_in or my_latch_reg) begin
    if (enable_sig) begin
        // When enable_sig is high, the latch is transparent and passes data_in
        my_latch_reg = data_in;
    end else begin
        // When enable_sig is low, the latch holds its current value.
        // This explicit self-assignment is expected to trigger W502.
        my_latch_reg = my_latch_reg; // <<< W502 violation expected here
    end
end

assign latch_output = my_latch_reg; // Connect internal register to the module output

endmodule
