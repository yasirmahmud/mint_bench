// Add placeholder modules to resolve ErrorAnalyzeBBox violations
module complexMUL
#(
    parameter WIDTH_PARAM          = 8,
    parameter POINT_PARAM       = 3
 )
 (
    input signed [WIDTH_PARAM-1:0] i_Ar,
    input signed [WIDTH_PARAM-1:0] i_Ai,
    input signed [WIDTH_PARAM-1:0] i_Br,
    input signed [WIDTH_PARAM-1:0] i_Bi,
    output signed [2*WIDTH_PARAM - POINT_PARAM : 0] o_MUL_r,
    output signed [2*WIDTH_PARAM - POINT_PARAM : 0] o_MUL_i
);
    // Placeholder behavior: Assign 0 for linting purposes
    assign o_MUL_r = 0;
    assign o_MUL_i = 0;
endmodule
