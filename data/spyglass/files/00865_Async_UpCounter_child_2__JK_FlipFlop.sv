module JK_FlipFlop (
    input clk_i,
    input rst_i,
    input j,
    input k,
    output reg Q
);

always @(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
        Q <= 1'b0;
    end else begin
        // Standard JK flip-flop truth table
        // J K | Q_next
        // 0 0 | Q (hold)
        // 0 1 | 0 (reset)
        // 1 0 | 1 (set)
        // 1 1 | ~Q (toggle)

        if (j == 1'b0 && k == 1'b0) begin
            // Q <= Q; // Hold value - implicit if no change
        end else if (j == 1'b0 && k == 1'b1) begin
            Q <= 1'b0;
        end else if (j == 1'b1 && k == 1'b0) begin
            Q <= 1'b1;
        end else if (j == 1'b1 && k == 1'b1) begin
            Q <= ~Q;
        end
    end
end

endmodule
