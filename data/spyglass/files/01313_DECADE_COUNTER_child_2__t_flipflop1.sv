// Definition for the T-flip-flop module
module t_flipflop1(
    input T,
    input clk,
    input rst,
    output reg Q
);
    // Asynchronous reset, synchronous toggle
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            Q <= 1'b0; // Reset Q to 0
        end else begin
            if (T) begin
                Q <= ~Q; // Toggle Q if T is high
            end
            // If T is low, Q holds its value (Q <= Q is implicit)
        end
    end
endmodule
