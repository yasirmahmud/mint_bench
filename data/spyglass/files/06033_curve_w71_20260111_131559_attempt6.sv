module curve_w71_20260111_131559_attempt6 (
    input       sel, // Single-bit selector
    input       data_in,
    output reg  y
);

always @ (*) begin
    // The target signal 'y' is NOT assigned a default value before the case statement.
    // This satisfies the condition "not preceded by assignment of target signal in combinational block".
    case (sel) // W71 violation expected on this line
        1'b0: y = data_in;
        // The case for sel = 1'b1 is not covered.
        // There is no 'default' clause.
        // This fulfills all conditions for W71: "Case statement does not have a default clause
        // and is not preceded by assignment of target signal in combinational block".
    endcase
end

endmodule
