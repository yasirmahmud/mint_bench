// Dummy module for MY_MUX definition, included in the same file as per constraints.
module MY_MUX (
    input [7:0] IN0,
    input [7:0] IN1,
    input SEL,
    output [7:0] OUT
);
    assign OUT = SEL ? IN1 : IN0;
endmodule
