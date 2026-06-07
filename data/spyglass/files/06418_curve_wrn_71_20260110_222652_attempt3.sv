module curve_wrn_71_20260110_222652_attempt3 (
    input clk,
    input rst_n,
    input [7:0] data_in,
    output [7:0] data_out
);

    // Define NVDLA_MCIF_BURST_SIZE_LOG2 as a real parameter
    // such that (3 - NVDLA_MCIF_BURST_SIZE_LOG2) evaluates to a positive non-integer.
    // Example: 3 - 1.5 = 1.5
    // This value is not an integer, which directly targets WRN_71: "Repetition multiplier ... must be an integer".
    // It is also positive (1.5), which helps avoid WRN_47 and SYNTH_5411 (negative or zero multipliers).
    parameter real NVDLA_MCIF_BURST_SIZE_LOG2 = 1.5;

    // Define a width for internal signals.
    localparam TMP_DATA_WIDTH = 4;
    // Calculate the result width by accommodating the integer part of the non-integer repetition multiplier.
    // floor(3 - NVDLA_MCIF_BURST_SIZE_LOG2) = floor(1.5) = 1.
    // So, RESULT_WIDTH = 4 + 1 = 5 bits.
    localparam RESULT_WIDTH = (TMP_DATA_WIDTH + $floor(3 - NVDLA_MCIF_BURST_SIZE_LOG2));

    reg [TMP_DATA_WIDTH-1:0] val_a;
    reg [TMP_DATA_WIDTH-1:0] val_b;

    wire [RESULT_WIDTH-1:0] result_a;
    wire [RESULT_WIDTH-1:0] result_b;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            val_a <= '0;
            val_b <= '0;
        end else begin
            // Use different parts of data_in to ensure distinct usage and avoid unused signals.
            val_a <= data_in[TMP_DATA_WIDTH-1:0];       // Uses data_in[3:0]
            val_b <= data_in[TMP_DATA_WIDTH*2-1:TMP_DATA_WIDTH]; // Uses data_in[7:4]
        end
    end

    // First assignment: Triggers WRN_71.
    // The repetition multiplier (3 - NVDLA_MCIF_BURST_SIZE_LOG2) evaluates to 1.5, which is not an integer.
    // Replicating 1'b1 for distinction from previous attempt.
    assign result_a = {{(3-NVDLA_MCIF_BURST_SIZE_LOG2){1'b1}}, val_a};

    // Second assignment: Triggers WRN_71.
    // This generates the second required occurrence of the violation.
    assign result_b = {{(3-NVDLA_MCIF_BURST_SIZE_LOG2){1'b1}}, val_b};

    // Use results to avoid unused signal warnings and drive data_out.
    // Both result_a and result_b are RESULT_WIDTH (5) bits wide.
    // data_out is 8 bits, so {3'b0, ...} extends them to 8 bits without mismatch.
    assign data_out = {3'b0, result_a} ^ {3'b0, result_b};

endmodule
