module expreg_dec(
    input [2:0] cyc0_type,
    output [1:0] aexp_sel, bexp_sel
);
    assign aexp_sel = 2'b0;
    assign bexp_sel = 2'b0;

    // Dummy assignment to consume unused inputs and resolve W240 violations
    wire _dummy_expreg_unused;
    assign _dummy_expreg_unused = |cyc0_type;
endmodule
