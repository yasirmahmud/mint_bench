module curve_w336_20260111_200852_307226_w7792_attempt6 (
    input clk
);

reg [13:0] center;

always @(posedge clk) begin
    center = center + 14'd1; // W336: Blocking assignment in a flip-flop inferred sequential block
end

endmodule
