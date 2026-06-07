module another_top (
    input wire clk
);
    // Fix for SYNTH_132: Hierarchical references are not supported for synthesis.
    // Defined a localparam in 'another_top' to hold the size, mirroring 'another_sub's parameter.
    localparam TOP_SIZE_PARAM = 8;

    // Fix for SYNTH_132: Pass the parameter explicitly to the sub-module instance.
    another_sub #(.SIZE_PARAM(TOP_SIZE_PARAM)) sub_inst_2 (.in_val(1'b0));

    // Fix for SYNTH_132: Use the localparam for the array declaration instead of hierarchical reference.
    reg [TOP_SIZE_PARAM-1:0] data_bus;

    always @(posedge clk) begin
        data_bus <= 0;
    end

    // The previous attempt to fix W528 on 'data_bus' by introducing '_unused_data_bus'
    // led to a new W528 violation on '_unused_data_bus[7:0]' (listed violation).
    // Removing '_unused_data_bus' resolves the W528 on itself.
    // W528 on 'data_bus' is not among the currently listed violations to fix.
endmodule
