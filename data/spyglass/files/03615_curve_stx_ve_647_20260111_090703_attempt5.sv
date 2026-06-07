module curve_stx_ve_647_20260111_090703_attempt5 (
    i_clock,
    i_reset,
    o_status
);

    // Standard Verilog-2001 port declarations
    input i_clock;
    input i_reset;
    output o_status;

    // A simple register to use the declared ports, ensuring they are not unused.
    reg r_internal_status;

    always @(posedge i_clock or posedge i_reset) begin
        if (i_reset) begin
            r_internal_status <= 1'b0;
        end else begin
            r_internal_status <= ~r_internal_status; // Toggling logic for distinctness
        end
    end

    assign o_status = r_internal_status;

    // This declaration triggers STX_VE_647.
    // 'i_extra_config_input' is declared as an 'input' within the module body,
    // but its name is NOT present in the module header's port list
    // (i_clock, i_reset, o_status).
    // It is intentionally not used in logic to avoid potential STX_VE_606
    // ("Identifier not declared in current scope") or other secondary violations,
    // following the successful strategy of previous attempts which achieved
    // "only_target: True". This ensures only the STX_VE_647 rule is triggered.
    input i_extra_config_input;

endmodule
