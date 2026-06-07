module curve_wrn_68_20260111_074153_attempt4 (
    input clk,
    input rst_n,
    output data_out
);

    // WRN_68: This is a multiple declaration for port 'data_out'.
    // 'data_out' is already implicitly declared as a wire by its presence
    // in the ANSI port list as an 'output' port. Redeclaring it as 'reg'
    // causes the violation.
    reg data_out;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out <= 1'b0;
        end else begin
            data_out <= 1'b1;
        end
    end

endmodule
