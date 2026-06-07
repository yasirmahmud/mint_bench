// Dummy module definition for counter to resolve black-box error
module counter #(parameter DATA_WIDTH = 8, parameter COUNT_FROM = 0) (
    input clk,
    input en,
    input rst,
    output reg [DATA_WIDTH-1:0] out
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out <= COUNT_FROM;
        end else if (en) begin
            out <= out + 1;
        end
    end
endmodule
