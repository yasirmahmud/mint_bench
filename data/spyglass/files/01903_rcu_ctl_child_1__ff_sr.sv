// Dummy module for ff_sr (simple flop with synchronous reset)
module ff_sr (
    output reg out,
    input din,
    input clk,
    input reset_l
);
    always @(posedge clk or negedge reset_l) begin
        if (!reset_l) begin
            out <= 1'b0;
        end else begin
            out <= din;
        end
    end
endmodule
