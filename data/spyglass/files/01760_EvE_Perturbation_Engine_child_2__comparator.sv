// Define comparator module (resolves ErrorAnalyzeBBox for 'comparator')
module comparator #(parameter WIDTH = 32) (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output equal,
    output lower,
    output greater
);
    assign equal = (a == b);
    assign lower = (a < b);
    assign greater = (a > b);
endmodule
