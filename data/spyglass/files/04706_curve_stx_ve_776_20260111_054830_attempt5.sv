module curve_stx_ve_776_20260111_054830_attempt5 (
    input wire clk,
    input wire enable_in,
    output reg [7:0] data_out
);

    // Rule: STX_VE_776 - Always statement not allowed in this scope
    // A 'function' is a procedural scope where 'always' blocks are not permitted.
    // Placing an 'always' block directly inside a function definition should trigger this rule.
    function automatic [7:0] my_invalid_func;
        input [7:0] func_data_in;
        reg [7:0] internal_reg;

        begin
            // The 'always' statement below is in an invalid scope (inside a 'function').
            // This directly violates STX_VE_776 as 'always' blocks are top-level constructs
            // and cannot be nested inside functions or tasks.
            always @(posedge clk) begin // Expected STX_VE_776 violation on this line
                if (enable_in) begin
                    internal_reg <= func_data_in;
                end else begin
                    internal_reg <= 8'h00;
                end
            end
            // A function must assign a value to its own name.
            my_invalid_func = internal_reg;
        end
    endfunction

    // Use the function to avoid unused warnings and provide context for clk/enable_in.
    // The outer always block assigns the function's (combinatorial) return value to data_out.
    always @(*) begin
        data_out = my_invalid_func(8'hAA);
    end

endmodule
