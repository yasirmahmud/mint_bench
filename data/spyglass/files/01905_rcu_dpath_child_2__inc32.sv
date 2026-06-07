// inc32
module inc32 (
    input [31:0] ai,
    output [31:0] sum
);
    assign sum = ai + 32'd1;
endmodule
