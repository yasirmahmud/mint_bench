module curve_wrn_71_20260110_222652_attempt6 (
    input wire clk,
    input wire rst_n,
    input wire [7:0] data_in,
    output wire [5:0] result_a,
    output wire [5:0] result_b
);

    // Define an integer parameter that contributes to a real number calculation.
    parameter int NUMERATOR = 5;

    // This localparam calculates a real number (2.5) for the repetition multiplier.
    // The division with a real literal (2.0) ensures the result is a real number.
    // Using this real number in the replication operator will trigger WRN_71.
    localparam real REPETITION_MULTIPLIER = NUMERATOR / 2.0; // Evaluates to 2.5

    // Define the width of the data part to be concatenated.
    localparam int DATA_PART_WIDTH = 4;

    // Calculate the output width. The effective number of bits prepended by the replication
    // is determined by the integer part of REPETITION_MULTIPLIER ($floor(2.5) = 2).
    localparam int OUTPUT_WIDTH = DATA_PART_WIDTH + $floor(REPETITION_MULTIPLIER); // 4 + 2 = 6

    reg [DATA_PART_WIDTH-1:0] internal_data_a;
    reg [DATA_PART_WIDTH-1:0] internal_data_b;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            internal_data_a <= '0;
            internal_data_b <= '0;
        end else begin
            // Assign different parts of data_in to ensure all input bits are used
            // and internal_data_a/b are properly driven.
            internal_data_a <= data_in[DATA_PART_WIDTH-1:0];               // Uses data_in[3:0]
            internal_data_b <= data_in[(DATA_PART_WIDTH*2)-1 : DATA_PART_WIDTH]; // Uses data_in[7:4]
        end
    end

    // First assignment: Triggers WRN_71.
    // The repetition multiplier REPETITION_MULTIPLIER (2.5) is a real number, not an integer,
    // which is the exact condition for WRN_71. The tool implicitly truncates it to 2 for bit generation.
    assign result_a = {{REPETITION_MULTIPLIER{1'b0}}, internal_data_a};

    // Second assignment: Triggers WRN_71 again, creating the second required instance of the violation.
    assign result_b = {{REPETITION_MULTIPLIER{1'b0}}, internal_data_b};

endmodule
