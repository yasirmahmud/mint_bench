module curve_wrn_68_20260111_074153_attempt3 (
    input clk,
    output data_out
);

    // WRN_68: This is a multiple declaration for port 'data_out'.
    // 'data_out' is already implicitly declared as a wire by its presence
    // in the ANSI port list as an 'output' port. Redeclaring it as 'reg'
    // causes the violation.
    reg data_out;

    always @(posedge clk) begin
        data_out <= clk;
    end

endmodule
