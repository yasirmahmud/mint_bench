module curve_stx_ve_776_20260111_054830_attempt6 (
    input wire clk,
    output wire dummy_out
);

    // Rule: STX_VE_776 - Always statement not allowed in this scope
    // Placing an 'always' procedural block directly inside a function definition is a direct violation.
    // Functions are combinatorial and cannot contain 'always' blocks.
    function automatic integer dummy_func;
        // The 'always' block below is in an invalid scope (inside a 'function').
        // This directly violates STX_VE_776.
        always @(posedge clk) begin // Expected STX_VE_776 violation on this line
            // This block does not perform any assignments to local variables
            // to minimize the chance of other syntax or semantic errors.
            $display("Always block found in invalid scope.");
        end
        // A function must assign a value to its own name.
        dummy_func = 1; 
    endfunction

    // Use the function to prevent unused port warnings for dummy_out.
    // The actual return value is irrelevant for triggering the syntax violation within the function.
    assign dummy_out = dummy_func;

endmodule
