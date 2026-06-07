// Definition for the comparator module (to resolve ErrorAnalyzeBBox violation)
module comparator #(
    parameter DATA_WIDTH = 8
) (
    input wire [DATA_WIDTH-1:0] a,
    input wire [DATA_WIDTH-1:0] b,
    output wire equal,
    output wire lower,
    output wire greater
);
    assign equal = (a == b);
    assign lower = (a < b);
    assign greater = (a > b);
endmodule
