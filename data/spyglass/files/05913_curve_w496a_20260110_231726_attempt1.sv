module curve_w496a_20260110_231726_attempt1 (
    input wire a,
    output reg out
);

always @(*) begin
    if (a == 1'bz) begin
        out = 1'b1;
    end else begin
        out = 1'b0;
    end
end

endmodule
