module curve_stx_ve_481_20260111_231549_311291_w38092_attempt11 (
    input wire clk,
    output reg out_val
);

    // An initial block is a standalone procedural block.
    initial begin
        out_val = 1'b0;
    end

    // The 'else' keyword here is illegal because it does not immediately follow
    // an 'if' statement. Placing it directly after another procedural block
    // (like 'initial') without a preceding 'if' is a syntax error.
    else begin
        out_val = 1'b1;
    end

endmodule
