module top_module (
    input  top_in_sig_0,
    output top_out_sig_0,
    input  top_in_sig_1,
    output top_out_sig_1
);

    // Violation 1: Portname 'in' and 'out' are used, but are not found in 'sub_module'.
    // This mimics the context example where all instance ports are misnamed.
    sub_module i_sub_0 (
        .in   (top_in_sig_0),  // Triggers STX_VE_282: Port 'in' not found in 'sub_module'
        .out  (top_out_sig_0)  // Port 'out' not found in 'sub_module' (may also trigger or be included in the 'in' report)
    );

    // Violation 2: Second instance to trigger the rule again.
    sub_module i_sub_1 (
        .in   (top_in_sig_1),  // Triggers STX_VE_282: Port 'in' not found in 'sub_module'
        .out  (top_out_sig_1)  // Port 'out' not found in 'sub_module' (may also trigger or be included in the 'in' report)
    );

endmodule
