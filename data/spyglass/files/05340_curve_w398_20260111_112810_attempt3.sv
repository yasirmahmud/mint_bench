module curve_w398_20260111_112810_attempt3 (
    input [3:0] selector,
    output reg out_val
);

always @(*) begin
    out_val = 1'b0; // Default assignment to avoid latch
    casex (selector)
        4'b1x1x: out_val = 1'b1;
        4'bx11x: out_val = 1'b0;
        default: out_val = 1'b0;
    endcase
end

endmodule
