// andGate module definition
module andGate(
    input wire i_a,
    input wire i_b,
    output wire o_out
);

assign o_out = i_a & i_b;

endmodule
