// Definition for D_flipflop
module D_flipflop(
    input clk, reset, d_in,
    output reg q_out
);
    // The D_flipflop in the main module is instantiated with ~clk,
    // so it will be effectively negative-edge triggered with respect to the main clk.
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q_out <= 1'b0; // Reset to 0
        end else begin
            q_out <= d_in; // Latch data input
        end
    end
endmodule
