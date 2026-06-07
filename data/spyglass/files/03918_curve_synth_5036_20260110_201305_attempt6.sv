module curve_synth_5036_20260110_201305_attempt6 (
    input wire [7:0] in_a,
    input wire [7:0] in_b,
    input wire [7:0] in_c,
    input wire [7:0] in_d,
    output wire [7:0] out1,
    output wire [7:0] out2
);

    // Function 1: Non-blocking assignment to function return value in a subprogram
    // This will be treated as blocking for synthesis, triggering SYNTH_5036.
    function [7:0] func_violator_1 (input [7:0] arg1, input [7:0] arg2);
        begin
            func_violator_1 <= arg1 + arg2; // Violation 1 for SYNTH_5036
        end
    endfunction

    // Function 2: Another instance of non-blocking assignment to function return value
    // This will also be treated as blocking for synthesis, triggering SYNTH_5036.
    function [7:0] func_violator_2 (input [7:0] arg3, input [7:0] arg4);
        begin
            func_violator_2 <= arg3 - arg4; // Violation 2 for SYNTH_5036
        end
    endfunction

    // Instantiate the functions to ensure they are used and avoid unused signal warnings
    assign out1 = func_violator_1(in_a, in_b);
    assign out2 = func_violator_2(in_c, in_d);

endmodule
