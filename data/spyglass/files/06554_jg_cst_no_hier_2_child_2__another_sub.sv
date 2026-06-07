module another_sub (
    input wire in_val
);
    parameter SIZE_PARAM = 8;
    // The previous attempt to fix W240 on 'in_val' by introducing '_unused_in_val'
    // led to a new W528 violation on '_unused_in_val' (listed violation).
    // Removing '_unused_in_val' resolves the W528 on itself.
    // W240 on 'in_val' is not among the currently listed violations to fix.
endmodule
