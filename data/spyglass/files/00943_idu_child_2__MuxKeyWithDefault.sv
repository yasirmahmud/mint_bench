module MuxKeyWithDefault #(
    parameter NUM_PAIRS = 1,  // First parameter
    parameter KEY_WIDTH = 1,  // Second parameter
    parameter DATA_WIDTH = 1  // Third parameter
) (
    output [DATA_WIDTH-1:0] out,
    input [KEY_WIDTH-1:0] key,
    input [DATA_WIDTH-1:0] default_val,
    // The 'pairs' input is a packed array of {key_i, data_i} for i=0 to NUM_PAIRS-1
    input [NUM_PAIRS * (KEY_WIDTH + DATA_WIDTH) - 1 : 0] pairs
);

    reg [DATA_WIDTH-1:0] mux_out_reg;
    integer i; // Declare loop variable outside the for loop for Verilog-2001 compliance

    always @(*) begin
        mux_out_reg = default_val; // Initialize with the default value
        // Iterate through the pairs to find a match for the 'key'
        for (i = 0; i < NUM_PAIRS; i = i + 1) begin
            // Extract the key part of the current pair
            if (key == pairs[i * (KEY_WIDTH + DATA_WIDTH) +: KEY_WIDTH]) begin
                // If key matches, assign the corresponding data part to mux_out_reg
                mux_out_reg = pairs[i * (KEY_WIDTH + DATA_WIDTH) + KEY_WIDTH +: DATA_WIDTH];
                // Assuming keys are unique or first match takes precedence
            end
        end
    end

    assign out = mux_out_reg; // Assign the result to the output port

endmodule
