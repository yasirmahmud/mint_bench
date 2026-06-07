module curve_w398_20260111_112810_attempt5 (
    input [3:0] selector,
    output reg out_val
);

always @(*) begin
    out_val = 1'b0; // Default assignment to avoid latch
    casex (selector)
        4'b10x0: out_val = 1'b1;
        4'b1x00: out_val = 1'b0; // This case item overlaps with 4'b10x0 for value 4'b1000
        default: out_val = 1'b0;
    endcase
end

endmodule
