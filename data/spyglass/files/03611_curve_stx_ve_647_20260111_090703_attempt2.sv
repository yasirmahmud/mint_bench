module curve_stx_ve_647_20260111_090703_attempt2 (
    data_in,
    data_out,
    clk
);

    // Standard Verilog-2001 port declarations for header ports
    input data_in;
    output data_out;
    input clk;

    // This declaration triggers STX_VE_647.
    // 'extra_input' is declared as input, but its name is not present
    // in the module header's port list (data_in, data_out, clk).
    input extra_input;

    reg data_out_reg;

    always @(posedge clk) begin
        data_out_reg <= data_in;
    end

    assign data_out = data_out_reg;

endmodule
