module curve_synth_5034_20260111_134108_attempt1 (
    input [1:0] data_in,
    output reg result_out
);

always @(*) begin
    result_out = 1'b0; // Default assignment to avoid unintended latches
    case (data_in) // Standard 'case' statement performs bit-wise exact comparison
        2'b00: result_out = 1'b0;
        2'b01: result_out = 1'b1;
        // This case item uses 'x' for a don't care. In a strict 'case' statement,
        // this implies that 'data_in' must literally have an 'x' at bit 0 to match.
        // Since 'data_in' is typically a signal composed of 0s and 1s during synthesis
        // and runtime, this comparison will always be false, triggering SYNTH_5034.
        2'b1x: result_out = 1'b1; 
        2'b11: result_out = 1'b0; 
    endcase
end

endmodule
