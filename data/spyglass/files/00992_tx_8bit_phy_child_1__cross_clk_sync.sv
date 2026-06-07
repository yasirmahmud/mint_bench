// Dummy module definition for cross_clk_sync (ErrorAnalyzeBBox fix)
// This module implements a simple N-stage synchronizer for cross-clock domain signals.
module cross_clk_sync #(
    parameter LAT = 2,
    parameter DSIZE = 1
)(
    input clk,
    input rst_n,
    input [DSIZE-1:0] d,
    output [DSIZE-1:0] q
);
    reg [DSIZE-1:0] sync_reg [LAT-1:0];
    integer i;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < LAT; i = i + 1) begin
                sync_reg[i] <= {DSIZE{1'b0}};
            end
        end else begin
            sync_reg[0] <= d;
            for (i = 1; i < LAT; i = i + 1) begin
                sync_reg[i] <= sync_reg[i-1];
            end
        end
    end
    assign q = sync_reg[LAT-1];
endmodule
