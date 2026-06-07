module another_sub (
    input wire in_val
);
    parameter SIZE_PARAM = 8;
    // Fix for W240: Input 'in_val' declared but not read.
    // Added a dummy usage to prevent the warning without changing functional behavior.
    wire _unused_in_val = in_val;
endmodule
