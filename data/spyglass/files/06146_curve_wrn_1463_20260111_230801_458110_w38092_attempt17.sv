module curve_wrn_1463_20260111_230801_458110_w38092_attempt17 (
    input wire clk_i,
    input wire reset_n_i,
    input wire in_value_i,
    output reg out_status_o
);

reg internal_state;

always @(posedge clk_i or negedge reset_n_i) begin
    if (!reset_n_i) begin
        internal_state <= 1'b0;
        out_status_o <= 1'b0;
    end else begin
        internal_state <= in_value_i;
        out_status_o <= internal_state;
    end
end

// The 'endmodule' statement is intentionally omitted to trigger WRN_1463.
