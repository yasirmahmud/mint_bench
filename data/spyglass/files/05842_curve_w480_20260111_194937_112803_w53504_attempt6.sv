module curve_w480_20260111_194937_112803_w53504_attempt6 (
    input wire clk,
    input wire rst_n,
    output reg [7:0] counter_out
);

reg [3:0] loop_idx; // Declared as reg, not integer, to trigger W480

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        counter_out <= 8'h00;
    end else begin
        // The loop index 'loop_idx' is of type 'reg' instead of 'integer'.
        // This will trigger the W480 violation.
        for (loop_idx = 4'd0; loop_idx < 4'd5; loop_idx = loop_idx + 4'd1) begin
            counter_out <= counter_out + 8'd1;
        end
    end
end

endmodule
