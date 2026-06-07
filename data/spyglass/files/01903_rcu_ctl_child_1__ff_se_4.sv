// Dummy module for ff_se_4 (4-bit flop with enable, no reset)
module ff_se_4 (
    output reg [3:0] out,
    input [3:0] din,
    input clk,
    input enable
);
    always @(posedge clk) begin
        if (enable) begin
            out <= din;
        end
    end
endmodule
