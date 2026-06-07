module curve_w339a_20260111_185304_096466_w53504_attempt8 (
    input [1:0] data_in_a,
    input [1:0] data_in_b,
    output wire data_out
);

    // W339a: Operator '!==' should be avoided in synthesis logic
    // This continuous assignment uses the case inequality operator '!==',
    // which is synthesizable but generally discouraged in synthesis due
    // to its handling of X and Z values. Using it in a direct assignment
    // within synthesizable logic will trigger W339a without causing
    // other common synthesis warnings like ignored initial blocks or latches.
    assign data_out = (data_in_a !== data_in_b);

endmodule
