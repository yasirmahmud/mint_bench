// Top module definition
module curve_synth_132_20260111_023509_attempt3 (
    input clk,
    output [7:0] final_output
);

    // Instantiate the sub_module with a specific parameter value.
    sub_module #(
        .DATA_BITS(8)
    ) u_sub_inst (
        .clk(clk),
        .data_out() // Explicitly leave output unconnected to prevent unused signal warnings in this module.
    );

    // SYNTH_132 violation: Hierarchical reference used directly in a constant expression
    // for a register's width. 'u_sub_inst.DATA_BITS' refers to a parameter of an instantiated module.
    reg [u_sub_inst.DATA_BITS - 1:0] internal_data_reg;

    // To avoid W528 (variable set but not read), 'internal_data_reg' must be both set and read.

    // 1. Set 'internal_data_reg' in an always block:
    always @(posedge clk) begin
        internal_data_reg <= {u_sub_inst.DATA_BITS{1'b1}}; // Dummy assignment, uses the derived width.
    end

    // 2. Read 'internal_data_reg' by connecting it to an output.
    // 'final_output' is declared as [7:0], which matches the 8-bit width of u_sub_inst.DATA_BITS.
    assign final_output = internal_data_reg;

endmodule
