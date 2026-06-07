module curve_synth_5036_20260110_201305_attempt8 (
    input wire [7:0] in_a,
    input wire [7:0] in_b,
    input wire [7:0] in_c,
    input wire [7:0] in_d,
    output wire [7:0] out1,
    output wire [7:0] out2
);

    // Function 1: Contains a non-blocking assignment directly to the function's return value.
    // SpyGlass SYNTH_5036 will be triggered as this non-blocking assignment in a subprogram
    // will be treated as blocking for synthesis. This constitutes the first occurrence.
    function automatic [7:0] my_sum_func (input [7:0] val1, input [7:0] val2);
        begin
            my_sum_func <= val1 + val2; // Violation 1 for SYNTH_5036
        end
    endfunction

    // Function 2: Another instance with a non-blocking assignment directly to its return value.
    // This will trigger SYNTH_5036 again, constituting the second occurrence.
    function automatic [7:0] my_diff_func (input [7:0] val1, input [7:0] val2);
        begin
            my_diff_func <= val1 - val2; // Violation 2 for SYNTH_5036
        end
    endfunction

    // Use the functions to drive outputs, ensuring they are active in the design
    assign out1 = my_sum_func(in_a, in_b);
    assign out2 = my_diff_func(in_c, in_d);

endmodule
