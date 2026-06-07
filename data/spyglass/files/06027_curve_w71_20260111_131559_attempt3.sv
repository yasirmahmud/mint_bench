module curve_w71_20260111_131559_attempt3 (
    input [1:0] sel,
    input       i0,
    input       i1,
    output reg  y
);

always @ (*) begin
    // 'y' is NOT assigned before the case statement.
    case (sel) // W71 violation expected on this line
        2'b00: y = i0;
        2'b01: y = i1;
        // Cases 2'b10 and 2'b11 are not covered.
        // No 'default' clause is present.
        // This combination (no pre-assignment, no default, incomplete cases)
        // will trigger W71 as 'y' is not assigned for all possible inputs.
        // This will also lead to an inferred latch, which is a common consequence of W71.
    endcase
end

endmodule
