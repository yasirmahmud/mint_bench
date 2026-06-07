module curve_synth_5369_20260111_220530_364561_w38092_attempt12 (
    input [7:0] in_n,
    output [7:0] out_recursive_count
);

    // This function recursively counts down from current_val to 0, adding 1 at each step.
    // It is designed to trigger SYNTH_5369 if 'current_val' can exceed the recursion limit (e.g., 100).
    // The output will simply be the value of 'current_val' passed to it.
    function [7:0] recursive_counter;
        input [7:0] current_val;
        begin
            if (current_val == 8'd0) begin
                recursive_counter = 8'd0;
            end else begin
                // This recursive call line is expected to trigger SYNTH_5369
                // due to the potential recursion depth exceeding 100.
                recursive_counter = 8'd1 + recursive_counter(current_val - 1);
            end
        end
    endfunction

    // Connect the module output to the function's result.
    // Providing an input 'in_n' that is large enough (e.g., > 100) 
    // will cause the function to exceed the typical recursion limit.
    assign out_recursive_count = recursive_counter(in_n);

endmodule
