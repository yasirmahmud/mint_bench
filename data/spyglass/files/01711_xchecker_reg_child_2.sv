module xchecker_reg #(
    parameter DW = 32,
    parameter SIGNAL_NAME = ""
)
(
    input clk,
    input [DW-1 : 0] data_i
);

`ifdef PLATFORM_SIM
CHECK_X_REG:
    assert property (@(posedge clk)((^(data_i)) !== 1'bx))
    else $fatal("Error!", SIGNAL_NAME, ", detected a X value after posedge clk!\n");
`endif

// Dummy always_comb block to resolve W240 warnings
// for inputs clk and data_i, which are used in assertions
// but might not be recognized by all linting tools.
// This block has no functional impact on the design.
always_comb begin
    // Use an always-false condition to prevent synthesis from optimizing
    // any actual logic related to these "reads" while still making
    // the linter aware they are "accessed".
    if (1'b0) begin
        // Dummy reads using local variables to explicitly indicate intent to discard value.
        // The void'() syntax might not be universally supported by all linting frontends,
        // causing the reported syntax error. Using assignments to local variables
        // is a more widely supported SystemVerilog construct for this purpose.
        logic dummy_clk_val;
        logic [DW-1:0] dummy_data_val;
        dummy_clk_val = clk;
        dummy_data_val = data_i;
    end
end

endmodule
