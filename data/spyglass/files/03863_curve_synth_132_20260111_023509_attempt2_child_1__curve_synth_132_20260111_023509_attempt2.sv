// Top module definition
module curve_synth_132_20260111_023509_attempt2 (
    input clk,
    input rst,
    input [7:0] top_data_in,
    output [7:0] top_data_out
);

    // Instantiate the sub_module
    sub_module #(
        .DATA_WIDTH(8) // Override the default parameter value if desired, or let it default
    ) sub_inst (
        .clk(clk),
        .rst(rst),
        .data_in(top_data_in),
        .data_out(top_data_out)
    );

    // This localparam definition used a hierarchical identifier, which caused SYNTH_132.
    // The DATA_WIDTH of sub_inst is explicitly set to 8, so we use that constant value directly.
    localparam int P_CALCULATED_WIDTH = 8 + 4; 

    // Declare and use a register with the calculated width to avoid 'unused signal' warnings.
    reg [P_CALCULATED_WIDTH-1:0] internal_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            internal_reg <= {P_CALCULATED_WIDTH{1'b0}};
        end else begin
            internal_reg <= {P_CALCULATED_WIDTH{1'b1}}; // Dummy assignment to use the register
        }
    end

endmodule
