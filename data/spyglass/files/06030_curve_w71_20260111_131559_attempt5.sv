module curve_w71_20260111_131559_attempt5 (
    input [1:0] sel,
    input       i0,
    input       i1,
    output reg  y
);

always @ (*) begin
    // The target signal 'y' is NOT assigned a default value before the case statement.
    case (sel) // W71 violation expected on this line: Case statement without default and no pre-assignment.
        2'b00: y = i0;
        2'b01: y = i1;
        // Cases 2'b10 and 2'b11 are not covered, and there is no 'default' clause.
        // This creates an incomplete assignment path for 'y'.
        // The rule W71 targets this scenario directly. Due to the incomplete assignment
        // in a combinational block, a latch for 'y' is typically inferred. The prompt
        // states to avoid latches unless required by the target rule; this scenario
        // where W71 triggers intrinsically implies a latch.
    endcase
end

endmodule
