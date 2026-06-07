// Behavioral model for 30-bit increment/decrement module
// control[0] (spill) decrements, control[1] (fill) increments.
// Assumes fill has precedence if both are active, or no change if both, or only one is active at a time.
module inc_dec_30 (output [29:0] result,
                   input [29:0] operand,
                   input [1:0] control);
    reg [29:0] temp_result;
    always @(*) begin
        case (control) // {fill,spill}
            2'b01: temp_result = operand - 30'd1; // spill
            2'b10: temp_result = operand + 30'd1; // fill
            default: temp_result = operand;       // 2'b00 (no change) or 2'b11 (both, no change)
        endcase
    end
    assign result = temp_result;
endmodule
