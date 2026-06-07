module curve_inferlatch_20260111_205718_793222_w36056_attempt7 (
    input wire [1:0] select_i,
    input wire [3:0] data_a_i,
    input wire [3:0] data_b_i,
    output wire [3:0] q_o
);

reg [3:0] latch_data_reg;

always @(select_i or data_a_i or data_b_i) begin
    case (select_i)
        2'b00: latch_data_reg = data_a_i;
        2'b01: latch_data_reg = data_b_i;
        // Latch is inferred for 'latch_data_reg' because it is not assigned
        // when 'select_i' is 2'b10 or 2'b11, and there is no default assignment.
    endcase
end

assign q_o = latch_data_reg;

endmodule
