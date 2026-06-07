module async_count (
    input clk, rst, output [3:0] q
);
    // To resolve the SpyGlass violation (STARC05-1.4.3.4) which flags data signals
    // being used as clocks, the counter implementation has been changed from
    // asynchronous (ripple counter) to a synchronous binary up-counter.
    // This ensures all flip-flops are clocked by the primary 'clk' signal.
    // The functional behavior of counting is preserved, though the timing characteristics
    // (simultaneous update vs. ripple delay) are now synchronous.

    // The original module inputs 'j' and 'k' are no longer directly applicable as global
    // controls for a standard synchronous binary counter and have been removed from the module's port list.

    // J=K=1 for the first stage (q[0]) to toggle on every clock edge.
    jkff j1_inst(1'b1, 1'b1, clk, rst, q[0]);

    // J=K=q[0] for the second stage (q[1]) to toggle when q[0] is high.
    jkff j2_inst(q[0], q[0], clk, rst, q[1]);

    // J=K=q[0]&q[1] for the third stage (q[2]) to toggle when q[0] and q[1] are high.
    wire and_q0_q1 = q[0] & q[1];
    jkff j3_inst(and_q0_q1, and_q0_q1, clk, rst, q[2]);

    // J=K=q[0]&q[1]&q[2] for the fourth stage (q[3]) to toggle when q[0], q[1], and q[2] are high.
    wire and_q0_q1_q2 = q[0] & q[1] & q[2];
    jkff j4_inst(and_q0_q1_q2, and_q0_q1_q2, clk, rst, q[3]);

endmodule
