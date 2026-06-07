module curve_synth_5058_20260111_221834_925148_w49296_attempt11 (
    input [7:0] data_a,
    input [7:0] data_b,
    output reg strict_match_flag
);

    // SYNTH_5058: Operator (===) encountered. Treating as (==) for synthesis.
    // This violation occurs because the strict equality operator (===) is used,
    // which has specific behavior for 'x' and 'z' values during simulation
    // that synthesis tools generally cannot preserve, treating it instead like (==).
    always @* begin
        if (data_a === data_b) begin
            strict_match_flag = 1'b1;
        end else begin
            strict_match_flag = 1'b0;
        end
    end

endmodule
