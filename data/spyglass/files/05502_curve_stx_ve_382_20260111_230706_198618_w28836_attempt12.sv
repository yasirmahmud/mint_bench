module curve_stx_ve_382_20260111_230706_198618_w28836_attempt12 (
    input wire clk,
    input wire rst_n,
    input wire enable_update,
    input wire [7:0] input_data,
    input wire [3:0] dynamic_idx, // Non-constant component for part-select index
    output reg [7:0] output_slice
);

    reg [63:0] memory_array; // A wider register to simulate memory

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            memory_array <= 64'h0;
            output_slice <= 8'h0;
        end else if (enable_update) begin
            // Update a portion of memory_array to ensure it's used and avoid unused signal warning
            // Shift in new data and keep old data, assuming data_in is LSB portion
            memory_array <= {memory_array[55:0], input_data};

            // STX_VE_382 violation: The MSB index 'dynamic_idx + 10' is a non-constant expression.
            // The LSB index '3' is a constant integer literal.
            // This pattern ensures exactly one STX_VE_382 violation, as requested by the prompt,
            // similar to 'Example 2' in the provided context examples.
            output_slice <= memory_array[dynamic_idx + 10 : 3];
        end
    end

endmodule
