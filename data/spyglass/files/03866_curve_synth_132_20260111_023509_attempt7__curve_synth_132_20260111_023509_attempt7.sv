// Top module: curve_synth_132_20260111_023509_attempt7
// Triggers SYNTH_132 by using a hierarchical reference as the upper bound for a generate for loop.
module curve_synth_132_20260111_023509_attempt7 (
    input wire clk,
    input wire rst_n,
    input wire enable,
    input wire [7:0] data_in,
    output reg [7:0] data_out // Output is a register
);

    wire dummy_signal_from_sub;
    param_source_val u_param_source_val (
        .dummy_in(1'b0),
        .dummy_out(dummy_signal_from_sub)
    );

    // Use the dummy signal to avoid an unused wire warning
    reg dummy_reg;
    always @(posedge clk) begin
        dummy_reg <= dummy_signal_from_sub;
    end

    // The SYNTH_132 violation occurs here because 'u_param_source_val.COUNT_VAL'
    // is a hierarchical reference used as the upper bound for a generate for loop.
    // Such references are not supported for synthesis in this context, as generate
    // loop bounds must be synthesizable constant expressions.
    genvar i;
    generate
        for (i = 0; i < u_param_source_val.COUNT_VAL; i = i + 1) begin : gen_data_path
            // Each generated block has a simple register and its logic.
            reg [7:0] internal_reg;

            always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    internal_reg <= 8'h00;
                end else if (enable) begin
                    internal_reg <= data_in + i; // Example: each path adds an offset
                end
            end

            // This generate-if block ensures 'data_out' is driven by only one instance.
            // The condition (i == 0) is a constant expression for each generated block.
            if (i == 0) begin : output_connection
                // Only the first generated block (i=0) drives data_out.
                // This ensures 'data_out' has a single driver, preventing 'MULT_DRVR' violations.
                always @(posedge clk or negedge rst_n) begin
                    if (!rst_n) begin
                        data_out <= 8'h00;
                    end else begin
                        data_out <= internal_reg;
                    end
                end
            end
        end
    endgenerate

endmodule
