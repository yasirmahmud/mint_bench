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

            // Original violation: output_slice <= memory_array[dynamic_idx + 10 : 3];
            // Analysis of functional behavior:
            // The selected slice 'memory_array[dynamic_idx + 10 : 3]' has a width of 'dynamic_idx + 8'.
            // Since 'dynamic_idx' ranges from 0 to 15, the width ranges from 8 to 23.
            // 'output_slice' is 8 bits wide. Due to Verilog's assignment rules:
            // - If the selected slice width is 8 (when dynamic_idx = 0), output_slice gets memory_array[10:3].
            // - If the selected slice width is > 8 (when dynamic_idx > 0), the assignment to the 8-bit
            //   'output_slice' truncates the higher bits of the selected slice. The lower 8 bits of
            //   'memory_array[dynamic_idx + 10 : 3]' correspond to 'memory_array[10:3]'.
            // Therefore, the effective functional behavior for 'output_slice' is always 'memory_array[10:3]'.
            // The 'dynamic_idx' effectively has no impact on the final value assigned to 'output_slice'.
            // This corrected line preserves the effective functional behavior and resolves STX_VE_382.
            output_slice <= memory_array[10 : 3];
        end
    end

endmodule
