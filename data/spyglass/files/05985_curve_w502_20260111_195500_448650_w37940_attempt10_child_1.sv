module curve_w502_20260111_195500_448650_w37940_attempt10 (
    input wire        enable_sig,
    input wire [3:0]  data_in,
    output reg [3:0]  latch_output
);

reg [3:0] my_latch_reg;

always @(enable_sig or data_in) begin
    if (enable_sig) begin
        // When enable_sig is high, the latch is transparent and passes data_in
        my_latch_reg = data_in;
    end else begin
        // When enable_sig is low, the latch holds its current value.
        // By not assigning my_latch_reg, a transparent latch is implicitly inferred,
        // and the W502 violation due to explicit self-assignment is avoided.
    end
end

assign latch_output = my_latch_reg;

endmodule
