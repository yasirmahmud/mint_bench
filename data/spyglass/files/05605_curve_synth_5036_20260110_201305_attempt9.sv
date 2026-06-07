module curve_synth_5036_20260110_201305_attempt9 (
    input wire [7:0] data_in_a,
    input wire [7:0] data_in_b,
    input wire [7:0] data_in_c,
    output wire [7:0] result_out1,
    output wire [7:0] result_out2
);

    // Function 1: Contains a non-blocking assignment directly to the function's return value.
    // SpyGlass SYNTH_5036 will be triggered as this non-blocking assignment in a subprogram
    // will be treated as blocking for synthesis. This constitutes the first occurrence.
    function [7:0] calculate_increment (input [7:0] val);
        begin
            calculate_increment <= val + 8'd1; // Violation 1 for SYNTH_5036
        end
    endfunction

    // Function 2: Another instance with a non-blocking assignment directly to its return value.
    // This will trigger SYNTH_5036 again, constituting the second occurrence.
    function [7:0] calculate_sum (input [7:0] val_a, input [7:0] val_b);
        begin
            calculate_sum <= val_a + val_b; // Violation 2 for SYNTH_5036
        end
    endfunction

    // Use the functions to drive outputs, ensuring they are active in the design
    assign result_out1 = calculate_increment(data_in_a);
    assign result_out2 = calculate_sum(data_in_b, data_in_c);

endmodule
