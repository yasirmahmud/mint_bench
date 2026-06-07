module curve_synth_5036_20260110_201305_attempt7 (
    input wire [7:0] data_in_a,
    input wire [7:0] data_in_b,
    input wire [7:0] data_in_c,
    input wire [7:0] data_in_d,
    output wire [7:0] result_out1,
    output wire [7:0] result_out2
);

    // Function 1: Contains a non-blocking assignment to a local register.
    // SpyGlass SYNTH_5036 will be triggered as this non-blocking assignment in a subprogram
    // will be treated as blocking for synthesis.
    function automatic [7:0] calc_sum_func (input [7:0] val1, input [7:0] val2);
        reg [7:0] temp_sum;
        begin
            temp_sum <= val1 + val2; // Violation 1 for SYNTH_5036
            calc_sum_func = temp_sum;
        end
    endfunction

    // Function 2: Another instance with a non-blocking assignment to a local register.
    // This will also trigger SYNTH_5036 for the same reason.
    function automatic [7:0] calc_diff_func (input [7:0] val3, input [7:0] val4);
        reg [7:0] temp_diff;
        begin
            temp_diff <= val3 - val4; // Violation 2 for SYNTH_5036
            calc_diff_func = temp_diff;
        end
    endfunction

    // Use the functions to drive outputs, ensuring they are active in the design
    assign result_out1 = calc_sum_func(data_in_a, data_in_b);
    assign result_out2 = calc_diff_func(data_in_c, data_in_d);

endmodule
