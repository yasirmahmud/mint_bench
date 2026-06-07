// Definition of the sub_module that uses the 2D array input 'MEM'.
module sub_module (
    input wire [31:0] MEM [31:0], // 2D array input, matching 'top_mem'
    output wire [31:0] sub_out
);

    // To ensure the linter analyzes 'MEM[31]' and its constituent bits,
    // we must reference it. We use a bit from the *driven* portion of MEM[31]
    // (i.e., MEM[31][0], which is part of the [5:0] range) to avoid other warnings
    // while making sure MEM[31] is considered for analysis.
    // This use ensures the undriven portion MEM[31][31:6] will be detected.
    assign sub_out = { {31{1'b0}}, MEM[31][0] };

    // The target violation `UndrivenInTerm-ML` specifically points to
    // `b05.MEM[31][31:6]`. This corresponds to the `MEM[31][31:6]` slice
    // within this submodule's input port that is not driven by the parent module.

endmodule
