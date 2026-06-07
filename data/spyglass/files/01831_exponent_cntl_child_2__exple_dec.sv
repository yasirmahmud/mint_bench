module exple_dec(
    output le,
    input topsign, bele, aele, azle, bzle,
    input [3:0] expfunc
);
    assign le = 1'b0;

    // Dummy assignment to consume unused inputs and resolve W240 violations
    wire _dummy_exple_unused;
    assign _dummy_exple_unused = topsign | bele | aele | azle | bzle | |expfunc;
endmodule
