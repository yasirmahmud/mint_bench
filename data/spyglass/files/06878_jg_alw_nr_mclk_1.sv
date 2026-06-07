module multiple_clocks_1 (
    input clk1,
    input clk2,
    input d,
    output reg q
);

always @(posedge clk1 or posedge clk2) begin
    q <= d;
end

endmodule
