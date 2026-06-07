// Dummy module for MY_MUX definition, included in the same file as per constraints.
// This module does not need to be complex, just fulfill the instantiation requirements.
module MY_MUX (
    input [7:0] IN0,
    input [7:0] IN1,
    input SEL,
    output [7:0] OUT
);
    assign OUT = SEL ? IN1 : IN0;
endmodule
