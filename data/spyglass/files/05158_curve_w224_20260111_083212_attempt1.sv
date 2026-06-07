module curve_w224_20260111_083212_attempt1 (
    input wire clk,
    input wire rst_n,
    output reg is_empty
);

reg [2:0] count; // Multi-bit register

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count <= 3'b0;
    end else begin
        count <= count + 3'b1; // Increment count, ensures it's used
    end
end

// Trigger W224: Multi-bit expression 'count' found when one-bit expression expected
always @(*) begin
    is_empty <= count ? 1'b0 : 1'b1; // 'count' (multi-bit) used as a boolean condition
end

endmodule
