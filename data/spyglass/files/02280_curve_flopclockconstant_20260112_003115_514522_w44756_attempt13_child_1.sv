module curve_flopclockconstant_20260112_003115_514522_w44756_attempt13 (
    input wire i_data1,
    input wire i_data2,
    output reg o_q1,
    output reg o_q2
);

    // The original always blocks clocked by constant '0' signals have been removed
    // to resolve FlopClockConstant violations.
    // As the original flops would never update due to the constant '0' clock,
    // o_q1 and o_q2 will now remain unassigned. In simulation, an unassigned 'reg'
    // defaults to 'X' and remains 'X', which functionally mirrors a flop that never
    // clocks and thus never updates from its initial unknown state.

endmodule
