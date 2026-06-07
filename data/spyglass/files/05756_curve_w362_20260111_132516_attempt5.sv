module curve_w362_20260111_132516_attempt5 (
    input clk,
    input rst,
    input [7:0] data_value,
    input [31:0] limit_value,
    output reg comparison_result
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            comparison_result <= 1'b0;
        end else begin
            // W362: For operator (>), left expression: "data_value" width 8 should match right expression: "limit_value" width 32
            if (data_value > limit_value) begin
                comparison_result <= 1'b1;
            end else begin
                comparison_result <= 1'b0;
            end
        end
    end

endmodule
