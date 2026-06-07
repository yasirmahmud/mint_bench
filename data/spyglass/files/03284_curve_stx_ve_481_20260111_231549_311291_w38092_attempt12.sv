module curve_stx_ve_481_20260111_231549_311291_w38092_attempt12 (
    output reg out_signal
);

    // A fork-join block can contain procedural assignments.
    // Here it acts like an implicit initial block.
    fork
        out_signal = 1'b0;
    join

    // This 'else' keyword is illegal because it does not immediately follow
    // an 'if' statement. Placing it after a fork-join block (or any other
    // procedural block) without a preceding 'if' is a syntax error.
    else begin
        out_signal = 1'b1;
    end

endmodule
