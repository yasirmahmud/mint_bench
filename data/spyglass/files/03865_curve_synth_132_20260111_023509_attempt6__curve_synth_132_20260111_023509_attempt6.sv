// Top module: curve_synth_132_20260111_023509_attempt6
// Triggers SYNTH_132 by using a hierarchical reference in a generate-if condition.
module curve_synth_132_20260111_023509_attempt6 (
    input wire clk,
    input wire rst_n,
    input wire enable,
    input wire [7:0] data_in,
    output reg [7:0] data_out
);

    // Instantiate the source module. Its COUNT_VAL parameter is 4.
    param_source_val u_param_source_val ();

    // SYNTH_132 violation: Hierarchical reference 'u_param_source_val.COUNT_VAL'
    // is used in the condition of a generate-if block. Generate conditions
    // must be constant expressions that can be evaluated at elaboration time,
    // but hierarchical references are not supported for synthesis in this context.
    generate
        if (u_param_source_val.COUNT_VAL > 2) begin : gen_block_gt_2
            // Logic to be included if the condition is true (COUNT_VAL = 4 > 2)
            always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    data_out <= 8'd0;
                end else if (enable) begin
                    data_out <= data_in + 1;
                end
            end
        end else begin : gen_block_le_2
            // Logic to be included if the condition is false
            always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    data_out <= 8'd0;
                end else if (enable) begin
                    data_out <= data_in;
                end
            end
        end
    endgenerate

endmodule
