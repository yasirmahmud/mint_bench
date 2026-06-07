// Dummy module for ff_s (single-bit flop, no reset)
module ff_s (
    output reg out,
    input din,
    input clk
);
    always @(posedge clk) begin
        out <= din;
    end
endmodule
