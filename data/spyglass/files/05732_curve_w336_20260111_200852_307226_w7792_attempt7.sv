module curve_w336_20260111_200852_307226_w7792_attempt7 (
    input clk,
    input rst_n,
    input enable
);

reg [7:0] counter;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        counter <= 8'd0;
    end else if (enable) begin
        counter = counter + 8'd1; // W336 violation: Blocking assignment in a flip-flop inferred sequential block
    end
end

endmodule
