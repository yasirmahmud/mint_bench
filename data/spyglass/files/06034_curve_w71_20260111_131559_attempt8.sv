module curve_w71_20260111_131559_attempt8 (
    input        [1:0] selector_val,
    input        [7:0] data_val_0,
    input        [7:0] data_val_1,
    output   reg [7:0] result_reg
);

// Define local parameters for the case values to make the example distinct.
localparam SEL_STATE_0 = 2'b00;
localparam SEL_STATE_1 = 2'b01;

always @ (*) begin
    // The target signal 'result_reg' is NOT assigned a default value before the case statement.
    // This fulfills the W71 condition: "not preceded by assignment of target signal in combinational block".
    case (selector_val) // W71 violation expected on this line.
        SEL_STATE_0: result_reg = data_val_0;
        SEL_STATE_1: result_reg = data_val_1;
        // There is NO 'default' clause. This fulfills the other W71 condition.
        // Cases 2'b10 and 2'b11 for 'selector_val' are not covered.
        // Since 'result_reg' is a 'reg' type and is not assigned for all possible paths
        // within the 'always' block, and it is not pre-assigned, a latch will be inferred
        // for 'result_reg' for the unhandled 'selector_val' states. This will trigger
        // an 'InferLatch' violation alongside W71. This behavior is consistent with the
        // provided context examples (Example 1 and 2, which also show InferLatch with W71)
        // and is considered acceptable under the prompt's clause: "unless required by the target rule".
    endcase
end

endmodule
