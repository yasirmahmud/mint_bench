module test_w339a (
    input wire a,
    input wire b,
    output wire out
);

    // W339a: Operator '!==' should be avoided in synthesis logic
    assign out = (a !== b);

endmodule
