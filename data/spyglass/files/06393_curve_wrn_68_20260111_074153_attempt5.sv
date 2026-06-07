module curve_wrn_68_20260111_074153_attempt5 (
    input clk,
    input rst_n,
    output data_out, // Port declared in ANSI list (implicitly wire)
    input in_val
);

    // WRN_68: 'data_out' is already implicitly declared as a wire by its presence
    // in the ANSI port list as an 'output' port. Redeclaring it explicitly as 'wire'
    // causes the violation.
    wire data_out; // Multiple declaration for port 'data_out'

    // Use other ports to avoid unused signal warnings
    reg dummy_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            dummy_reg <= 1'b0;
        end else begin
            dummy_reg <= in_val;
        end
    end

    // Drive the 'data_out' wire. The violation is on the declaration itself.
    assign data_out = dummy_reg;

endmodule
