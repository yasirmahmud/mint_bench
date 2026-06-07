// Dummy module definition for comparator to resolve black-box error
module comparator #(parameter DATA_WIDTH = 32) (
    input [DATA_WIDTH-1:0] a,
    input [DATA_WIDTH-1:0] b,
    output reg equal,
    output reg lower,
    output reg greater
);
    always @(*) begin
        equal = (a == b);
        lower = (a < b);
        greater = (a > b);
    end
endmodule
