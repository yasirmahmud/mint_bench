module curve_synth_5369_20260112_005817_982726_w44756_attempt16 (
    input wire [8:0] initial_val, // Input value, can be > 100 to trigger deep recursion
    output reg [18:0] calculated_result // Output to store the recursive calculation result
);

    // Function to perform a recursive calculation. The recursion depth
    // can exceed 100 if 'initial_val' is greater than 100.
    // This design is specifically intended to trigger the SYNTH_5369 violation.
    function [18:0] recursive_process;
        input [8:0] current_n; // Current value for the recursive function
        begin
            if (current_n == 0) begin
                recursive_process = 18'd0; // Base case for the recursion
            end else begin
                // This recursive call line is the primary target for SYNTH_5369.
                // If 'current_n' is large (e.g., > 100), the recursion depth
                // will exceed the typical synthesis limit, causing the violation.
                recursive_process = (current_n * 2) + recursive_process(current_n - 1);
            end
        end
    endfunction

    always @(*) begin
        // The top-level call to the recursive function. Providing an
        // 'initial_val' greater than 100 ensures the recursion limit is hit.
        calculated_result = recursive_process(initial_val);
    end

endmodule
