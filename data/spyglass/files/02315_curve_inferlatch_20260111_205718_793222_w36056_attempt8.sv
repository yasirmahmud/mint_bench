module curve_inferlatch_20260111_205718_793222_w36056_attempt8 (
    input wire enable_i,
    input wire [3:0] data_i,
    output wire [3:0] q_o
);

reg [3:0] latch_reg;

always @(enable_i or data_i) begin
    // Latch is inferred for 'latch_reg' because it is only assigned
    // when 'enable_i' is high. When 'enable_i' is low, 'latch_reg'
    // retains its previous value, thus inferring a latch.
    if (enable_i) begin
        latch_reg = data_i;
    end
end

assign q_o = latch_reg;

endmodule
