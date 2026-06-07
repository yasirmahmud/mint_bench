module curve_stx_ve_647_20260111_090703_attempt4 (
    i_data_valid,
    o_data_out,
    i_clk,
    i_control_signal // Added to resolve STX_VE_647
);

    // Standard Verilog-2001 port declarations
    input i_data_valid;
    input i_clk;
    output o_data_out;

    // This declaration previously triggered STX_VE_647.
    // By adding 'i_control_signal' to the module header's port list,
    // this declaration is now valid.
    input i_control_signal;

    // Use other valid ports to avoid unused signal warnings for them.
    // 'i_control_signal' is INTENTIONALLY NOT USED in any logic to prevent
    // secondary violations like STX_VE_606 ('Identifier not declared in current scope'),
    // which would occur if it were used after being declared outside the port list.
    // This design choice is made to adhere to the strict requirement of triggering
    // *exactly one* STX_VE_647 violation, even if it might lead to an 'unused input'
    // warning/violation for 'i_control_signal' itself.
    assign o_data_out = i_data_valid && i_clk;

endmodule
