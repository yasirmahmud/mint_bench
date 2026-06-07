// Dummy module for ff_sre (simple flop with synchronous reset and enable)
module ff_sre (
    output reg out,
    input din,
    input reset_l,
    input clk,
    input enable
);
    always @(posedge clk or negedge reset_l) begin
        if (!reset_l) begin
            out <= 1'b0;
        end else if (enable) begin
            out <= din;
        }
    end
endmodule
