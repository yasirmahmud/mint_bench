module curve_stx_ve_776_20260111_054830_attempt6 (
    input wire clk,
    output wire dummy_out
);

    function automatic integer dummy_func;
        // A function must assign a value to its own name.
        dummy_func = 1; 
    endfunction

    // Use the function to prevent unused port warnings for dummy_out.
    // The actual return value is irrelevant for triggering the syntax violation within the function.
    assign dummy_out = dummy_func;

endmodule
