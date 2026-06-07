`default_nettype none

module curve_synth_5133_20260111_101310_attempt1 (
    input wire clk,
    input wire rst_n,
    input wire x,
    input wire y
);

    reg q;

    // Simple flop to use clk, rst_n, and x, preventing unused signal warnings.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 1'b0;
        end else begin
            q <= x;
        end
    end

    // This 'assign' statement continuously drives the input port 'y',
    // which is the direct cause of the SYNTH_5133 violation.
    assign y = q;

endmodule
