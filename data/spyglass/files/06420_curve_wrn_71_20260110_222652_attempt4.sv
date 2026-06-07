module curve_wrn_71_20260110_222652_attempt4 (
    input clk,
    input rst_n,
    input [7:0] data_in,
    output [7:0] data_out
);

    // Define NVDLA_MCIF_BURST_SIZE_LOG2 as a real parameter
    // such that (3 - NVDLA_MCIF_BURST_SIZE_LOG2) evaluates to a positive non-integer.
    // Example: 3 - 1.8 = 1.2
    // This value is not an integer, which directly targets WRN_71: "Repetition multiplier ... must be an integer".
    // It is also positive (1.2), which helps avoid WRN_47 and SYNTH_5411 (negative or zero multipliers).
    parameter real NVDLA_MCIF_BURST_SIZE_LOG2 = 1.8;

    // The calculated repetition value. This will be a real number.
    localparam real REPL_VALUE = (3 - NVDLA_MCIF_BURST_SIZE_LOG2); // Evaluates to 1.2

    // Define a width for internal signals.
    localparam TMP_DATA_WIDTH = 4;
    // Calculate the result width by accommodating the integer part of the non-integer repetition multiplier.
    // floor(REPL_VALUE) = floor(1.2) = 1.
    // So, RESULT_WIDTH = TMP_DATA_WIDTH + 1 = 5 bits.
    localparam RESULT_WIDTH = (TMP_DATA_WIDTH + $floor(REPL_VALUE));

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
    // The repetition multiplier REPL_VALUE (1.2) is a real number, not an integer, violating WRN_71.
    assign result_a = {{REPL_VALUE{1'b0}}, val_a};

    // Second assignment: Triggers WRN_71.
    // This generates the second required occurrence of the violation.
    assign result_b = {{REPL_VALUE{1'b0}}, val_b};

    // Use both result_a and result_b to avoid unused wire warnings.
    // Pad with zeros to match data_out width (8 bits).
    wire [RESULT_WIDTH-1:0] combined_results = result_a ^ result_b;
    assign data_out = {{(8-RESULT_WIDTH){1'b0}}, combined_results};

endmodule
