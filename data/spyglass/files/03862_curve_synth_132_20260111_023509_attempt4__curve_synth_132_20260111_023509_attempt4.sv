// Top module definition
module curve_synth_132_20260111_023509_attempt4 (
    input clk,
    input [7:0] top_in_data,
    output [7:0] top_out_data
);

    // Instantiate the sub_module with a specific parameter value.
    // All ports are connected to avoid W287b (unconnected port warnings).
    wire [7:0] sub_internal_data;
    sub_module #(
        .DATA_BITS(8) // Explicitly set parameter for the instance
    ) u_sub_inst (
        .clk(clk),
        .in_data(top_in_data),
        .out_data(sub_internal_data)
    );

    // SYNTH_132 violation: Hierarchical reference 'u_sub_inst.DATA_BITS'
    // is used in a localparam definition. This is not supported for synthesis.
    localparam INTERNAL_BUS_WIDTH = u_sub_inst.DATA_BITS;

    // Declare a register using the hierarchically referenced localparam.
    // This ensures 'INTERNAL_BUS_WIDTH' is used and prevents unused signal warnings.
    reg [INTERNAL_BUS_WIDTH-1:0] processed_data_reg;

    // Simple sequential logic to use the declared register and input data.
    always @(posedge clk) begin
        processed_data_reg <= sub_internal_data + 1; // Example operation
    end

    // Assign the processed data to the top-level output to avoid W528
    // (variable set but not read) for 'processed_data_reg'.
    assign top_out_data = processed_data_reg;

endmodule
