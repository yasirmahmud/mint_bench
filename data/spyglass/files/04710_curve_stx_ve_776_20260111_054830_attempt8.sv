module curve_stx_ve_776_20260111_054830_attempt8 (
    input wire clk,
    input wire in_data,
    output reg out_data
);

    // Rule: STX_VE_776 - Always statement not allowed in this scope
    // A 'function' is a combinational construct and cannot contain a continuous 'always' block.
    // Placing an 'always' block inside a function is a clear violation of this rule.

    function automatic [0:0] my_combinational_func (input [0:0] data_in);
        // The 'always' block below is in an invalid scope (inside a 'function').
        // This should directly trigger STX_VE_776.
        always @(data_in) begin // Expected STX_VE_776 violation on this line
            my_combinational_func = ~data_in;
        end
    endfunction

    always @(posedge clk) begin
        out_data <= my_combinational_func(in_data);
    end

endmodule
