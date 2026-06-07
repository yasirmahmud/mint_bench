module curve_inferlatch_20260111_205718_793222_w36056_attempt9 (
    input wire [1:0] sel_i,
    input wire [3:0] data_in_i,
    output wire [3:0] q_o
);

reg [3:0] inferred_latch_reg;

always @(sel_i or data_in_i) begin
    // A latch is inferred for 'inferred_latch_reg' because not all
    // possible conditions of 'sel_i' lead to an assignment.
    // Specifically, when 'sel_i' is 2'b10 or 2'b11, 'inferred_latch_reg'
    // retains its previous value, thus inferring a latch.
    case (sel_i)
        2'b00: begin
            inferred_latch_reg = data_in_i;
        end
        2'b01: begin
            inferred_latch_reg = ~data_in_i;
        end
        // The absence of a 'default' or explicit assignment for other 'sel_i' values
        // causes a latch inference.
    endcase
end

assign q_o = inferred_latch_reg;

endmodule
