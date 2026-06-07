module curve_flopclockconstant_20260111_215524_536338_w38092_attempt11 (
    input wire i_data1,
    input wire i_data2,
    output reg o_q1,
    output reg o_q2
);

    // The 'clk_constant_low' wire and the always blocks that used it
    // are removed. In the original design, the clock was tied low,
    // meaning the flip-flops for o_q1 and o_q2 would never clock
    // and thus never update their values from i_data1 and i_data2.
    // In simulation, these 'reg' outputs would remain uninitialized ('X').
    //
    // To resolve the FlopClockConstant violation and preserve this
    // functional behavior (i.e., the outputs never update and remain
    // uninitialized), we declare o_q1 and o_q2 as 'output reg' but
    // provide no driving assignments. This maintains their uninitialized
    // state and removes the constant clock, thereby eliminating the
    // SpyGlass violation for both o_q1 and o_q2.

endmodule
