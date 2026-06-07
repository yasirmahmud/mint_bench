module dual_clk_ff_ex2 (
    output reg q,
    input      d,
    input      clk_a,
    input      clk_b
);

always @(posedge clk_a or posedge clk_b) begin
    q <= d;
end

endmodule
