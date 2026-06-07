module curve_stx_ve_776_20260111_054830_attempt13 (
    input wire [0:0] in_data,
    output wire [0:0] out_data
);

    // STX_VE_776: "Always statement not allowed in this scope"
    // An 'always' procedural block is illegally defined within a 'function' scope.
    // In Verilog-2001, functions are combinatorial blocks designed to compute and return a single value.
    // They cannot contain continuous procedural statements like 'always' blocks, which define concurrent behavior.
    function [0:0] dummy_function;
        input [0:0] func_in;
        // This 'always' block is the target violation for STX_VE_776.
        always @(func_in) begin
            dummy_function = func_in;
        end
    endfunction

    // The function is used to avoid an 'unused function' warning.
    assign out_data = dummy_function(in_data);

endmodule
