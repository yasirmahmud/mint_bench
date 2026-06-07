module curve_w218_attempt9 (
    input [1:0] multi_input,
    output reg  out_reg
);

    // W218 violation: Edge specification (posedge) should not be used
    // for a multibit expression ('multi_input' is 2 bits wide).
    always @(posedge multi_input) begin
        out_reg <= 1'b0;
    end

endmodule
