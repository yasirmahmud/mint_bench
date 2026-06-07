module curve_wrn_71_20260110_222652_attempt5 (
    input wire clk,
    input wire rst_n,
    input wire [7:0] data_input,
    output wire [5:0] result_output_a,
    output wire [5:0] result_output_b
);

    // This localparam defines a real number that will be used as a repetition multiplier.
    // Using a real number (2.5) for the repetition multiplier will trigger WRN_71.
    localparam real REPETITION_FACTOR = 2.5;

    // Define the width of the data that will be concatenated.
    localparam int INPUT_DATA_WIDTH = 4;

    // Calculate the output width. The integer part of REPETITION_FACTOR ($floor(2.5) = 2)
    // determines how many bits are effectively prepended from the repetition.
    localparam int OUTPUT_DATA_WIDTH = INPUT_DATA_WIDTH + $floor(REPETITION_FACTOR); // 4 + 2 = 6

    reg [INPUT_DATA_WIDTH-1:0] internal_val_a;
    reg [INPUT_DATA_WIDTH-1:0] internal_val_b;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            internal_val_a <= '0;
            internal_val_b <= '0;
        end else begin
            // Assign different parts of data_input to ensure all input bits are used
            // and signals internal_val_a/b are driven.
            internal_val_a <= data_input[INPUT_DATA_WIDTH-1:0];       // Uses data_input[3:0]
            internal_val_b <= data_input[(INPUT_DATA_WIDTH*2)-1 : INPUT_DATA_WIDTH]; // Uses data_input[7:4]
        end
    end

    // First assignment: Triggers WRN_71.
    // The repetition multiplier REPETITION_FACTOR (2.5) is a real number, not an integer,
    // which is the exact condition for WRN_71.
    assign result_output_a = {{REPETITION_FACTOR{1'b0}}, internal_val_a};

    // Second assignment: Triggers WRN_71.
    // This creates the second instance of the violation as required.
    assign result_output_b = {{REPETITION_FACTOR{1'b0}}, internal_val_b};

endmodule
