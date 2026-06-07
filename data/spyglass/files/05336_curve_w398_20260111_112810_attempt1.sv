module curve_w398_20260111_112810_attempt1 (
    input [1:0] sel,
    output reg out
);

always @(*) begin
    out = 1'b0;
    casex (sel)
        2'b0x: out = 1'b0;
        2'bx0: out = 1'b1;
    endcase
end

endmodule
