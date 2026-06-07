`define MY_PARAMETER 1
`define MY_PARAMETER 2

module curve_wrn_26_20260112_013204_422440_w25608_attempt13 (
    input wire clk,
    input wire rst_n,
    output reg out_val
);

    // Using the macro avoids unused warnings. It will resolve to the last defined value.
    parameter LOCAL_VALUE = `MY_PARAMETER;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out_val <= 1'b0;
        end else begin
            out_val <= LOCAL_VALUE;
        end
    end

endmodule
