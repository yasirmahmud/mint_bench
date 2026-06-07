module curve_w398_20260111_112810_attempt4 (
    input [2:0] selector,
    output reg out_val
);

always @(*) begin
    out_val = 1'b0; // Default assignment to avoid latch
    casex (selector)
        3'b1?0: out_val = 1'b1;
        3'b?10: out_val = 1'b0;
        default: out_val = 1'b0;
    endcase
end

endmodule
