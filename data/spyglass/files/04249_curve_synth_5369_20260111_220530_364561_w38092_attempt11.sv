module curve_synth_5369_20260111_220530_364561_w38092_attempt11 (
    input [7:0] in_n,
    output [15:0] out_result
);

    // This function calculates the triangular number of n (sum of 1 to n).
    // It is designed to trigger SYNTH_5369 if 'n' can exceed the recursion limit (e.g., 100).
    function [15:0] calc_triangular;
        input [7:0] n;
        begin
            if (n == 8'd0) begin
                calc_triangular = 16'd0;
            end else begin
                // This recursive call line is expected to trigger SYNTH_5369
                // due to the potential recursion depth exceeding 100.
                calc_triangular = n + calc_triangular(n - 1);
            end
        end
    endfunction

    // Connect the module output to the function's result
    assign out_result = calc_triangular(in_n);

endmodule
