module curve_synth_5034_20260111_134108_attempt2 (
    input [1:0] data_in,
    output reg result_out
);

always @(*) begin
    result_out = 1'b0; // Default assignment to avoid unintended latches
    
    // The rule SYNTH_5034 states "Comparison with don't care or tristate will be always false".
    // During synthesis, input port bits like data_in[0] are generally assumed to be '0' or '1'.
    // Comparing a '0' or '1' with an 'x' (1'bx) will always evaluate to false.
    // Therefore, the condition 'data_in[0] == 1'bx' will always be false, triggering SYNTH_5034.
    // This construct uses an 'if' statement, avoiding the 'case item' context that triggered W337 
    // in previous attempts when using 'x' in case/casez items.
    if (data_in[0] == 1'bx) begin
        result_out = 1'b1; 
    end else if (data_in[1] == 1'b0) begin
        result_out = 1'b0;
    end else begin
        result_out = 1'b1;
    end
end

endmodule
