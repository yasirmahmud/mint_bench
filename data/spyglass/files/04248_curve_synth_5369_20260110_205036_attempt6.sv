module curve_synth_5369_20260110_205036_attempt6 (
    output wire [63:0] out_result_1,
    output wire [63:0] out_result_2
);

    // Define a constant wire that will represent the recursion depth.
    // This value is deliberately set above the common recursion limit (100).
    wire [7:0] recursion_trigger_val = 8'd150;

    // First recursive function to calculate factorial.
    // This subprogram is expected to trigger SYNTH_5369 once.
    function [63:0] factorial_func_a;
        input [7:0] n;
        begin
            if (n <= 1) begin
                factorial_func_a = 64'd1;
            end else begin
                // This recursive call exceeds the typical recursion limit.
                factorial_func_a = n * factorial_func_a(n - 1);
            end
        end
    endfunction

    // Second recursive function, distinct from the first.
    // This subprogram is also expected to trigger SYNTH_5369 once, for a total of two occurrences.
    function [63:0] factorial_func_b;
        input [7:0] n;
        begin
            if (n <= 1) begin
                factorial_func_b = 64'd1;
            end else begin
                // This recursive call also exceeds the typical recursion limit.
                factorial_func_b = n * factorial_func_b(n - 1);
            end
        end
    endfunction

    // Assign outputs by calling each recursive function with the specified depth.
    // Each function call should generate a distinct SYNTH_5369 violation, fulfilling
    // the requirement for 2 total occurrences.
    assign out_result_1 = factorial_func_a(recursion_trigger_val);
    assign out_result_2 = factorial_func_b(recursion_trigger_val);

endmodule
