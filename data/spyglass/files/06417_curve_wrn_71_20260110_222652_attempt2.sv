module curve_wrn_71_20260110_222652_attempt2 (
    input clk,
    input rst_n,
    input [7:0] data_in,
    output [7:0] data_out
);

    // Define NVDLA_MCIF_BURST_SIZE_LOG2 as a real parameter
    // such that (3 - NVDLA_MCIF_BURST_SIZE_LOG2) evaluates to a positive non-integer.
    // Example: 3 - 2.5 = 0.5
    // This value is not an integer, which directly targets WRN_71: "Repetition multiplier ... must be an integer".
    // It is also positive (0.5), which should avoid WRN_47 and SYNTH_5411,
    // as those rules typically report on negative or zero repetition multipliers.
    parameter real NVDLA_MCIF_BURST_SIZE_LOG2 = 2.5;

    // Define an integer width for internal signals to avoid other type/width errors.
    localparam TMP_WIDTH = 4;

    reg [TMP_WIDTH-1:0] ftran_size_tmp_1;
    reg [TMP_WIDTH-1:0] ftran_size_tmp_2;

    // Output wires for the concatenation.
    // Make them the same width as ftran_size_tmp_x.
    // This is done assuming that a non-integer repetition multiplier might result in zero bits
    // from the replicated part during tool evaluation, thereby preventing unintended width mismatch warnings.
    wire [TMP_WIDTH-1:0] ftran_size_out_1;
    wire [TMP_WIDTH-1:0] ftran_size_out_2;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ftran_size_tmp_1 <= '0;
            ftran_size_tmp_2 <= '0;
        end else begin
            // Use a portion of data_in to drive the registers
            ftran_size_tmp_1 <= data_in[TMP_WIDTH-1:0];
            ftran_size_tmp_2 <= data_in[TMP_WIDTH-1:0] + 1; // Assign different values to ensure separate usage
        end
    end

    // First assignment: Triggers WRN_71.
    // The repetition multiplier (3 - NVDLA_MCIF_BURST_SIZE_LOG2) evaluates to 0.5, which is not an integer.
    assign ftran_size_out_1 = {{(3-NVDLA_MCIF_BURST_SIZE_LOG2){1'b0}}, ftran_size_tmp_1};

    // Second assignment: Triggers WRN_71.
    // This generates the second required occurrence of the violation.
    assign ftran_size_out_2 = {{(3-NVDLA_MCIF_BURST_SIZE_LOG2){1'b0}}, ftran_size_tmp_2};

    // Drive the module output using the generated signals to avoid unused wire warnings.
    // This concatenates two TMP_WIDTH (4-bit) signals into an 8-bit output.
    assign data_out = {ftran_size_out_1, ftran_size_out_2};

endmodule
