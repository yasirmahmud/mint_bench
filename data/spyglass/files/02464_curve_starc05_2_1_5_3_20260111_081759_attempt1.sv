module curve_starc05_2_1_5_3_20260111_081759_attempt1 (
    input clk,
    input rst,
    input [3:0] data_in,
    output reg out_scalar
);

reg [3:0] count_reg;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        count_reg <= 4'h0;
        out_scalar <= 1'b0;
    end else begin
        count_reg <= data_in;
        // STARC05-2.1.5.3 violation: 'count_reg' is a multi-bit signal,
        // used directly as a conditional expression, which is not scalar.
        out_scalar <= count_reg ? 1'b1 : 1'b0;
    end
end

endmodule
