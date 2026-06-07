module curve_inferlatch_20260111_205718_793222_w36056_attempt6 (
    input wire enable_i,
    input wire [1:0] data_i,
    output wire [1:0] q_o
);

reg [1:0] internal_latch_reg;

always @(enable_i or data_i) begin
    if (enable_i) begin
        internal_latch_reg = data_i;
    end
    // Latch is inferred for 'internal_latch_reg' because it is not assigned
    // in the implicit 'else' path when 'enable_i' is low.
end

assign q_o = internal_latch_reg;

endmodule
