`default_nettype none

module curve_synth_5133_20260111_101310_attempt1 (
    input wire clk,
    input wire rst_n,
    input wire x,
    output wire y
);

    reg q;

    // Simple flop to use clk, rst_n, and x, preventing unused signal warnings.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 1'b0;
        end else begin
            q <= x;
        _end
    end

    // This 'assign' statement now correctly drives the output port 'y'.
    assign y = q;

endmodule
