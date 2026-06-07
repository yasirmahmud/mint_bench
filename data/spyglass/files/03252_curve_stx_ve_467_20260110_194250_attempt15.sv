module curve_stx_ve_467_20260110_194250_attempt15 (
    input wire clk,
    input wire reset_n,
    input wire [15:0] data_in_a,
    input wire [3:0] data_in_b,
    output reg [31:0] output_a,
    output reg [31:0] output_b
);

    // --- First violation (Occurrence 1) --- 
    // Source: Unpacked array of 16-bit registers
    reg [15:0] large_array [0:1]; // 2 elements, each 16-bit
    // Target: Packed scalar register (32-bit)
    reg [31:0] scalar_reg_target;

    // --- Second violation (Occurrence 2) ---
    // Source: Unpacked array of 1-bit registers
    reg bit_array [0:3]; // 4 elements, each 1-bit (reg without range implies 1-bit)
    // Target: Integer scalar
    integer integer_target;

    always @(*) begin
        // Populate large_array to avoid unused signal warnings
        large_array[0] = data_in_a;
        large_array[1] = data_in_a + 16'd1; // Ensure data_in_a is used across array

        // STX_VE_467 (Occurrence 1): Non-equivalent data types in assignment operation
        // Assigning an unpacked array 'large_array' to a packed scalar 'reg' type 'scalar_reg_target'.
        // This is a fundamental type mismatch, as an unpacked array cannot be directly assigned to a scalar.
        scalar_reg_target = large_array;

        // Populate bit_array to avoid unused signal warnings
        bit_array[0] = data_in_b[0];
        bit_array[1] = data_in_b[1];
        bit_array[2] = data_in_b[2];
        bit_array[3] = data_in_b[3];

        // STX_VE_467 (Occurrence 2): Non-equivalent data types in assignment operation
        // Assigning an unpacked array 'bit_array' to a scalar 'integer' type 'integer_target'.
        // This is a fundamental type mismatch, as an unpacked array cannot be directly assigned to a scalar.
        integer_target = bit_array;
    end

    // Use scalar_reg_target and integer_target to avoid unused signal warnings
    // and connect them to module outputs.
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            output_a <= 32'h0;
            output_b <= 32'h0;
        end else begin
            output_a <= scalar_reg_target; // Assign 32-bit scalar to 32-bit output
            output_b <= integer_target;    // Assign 32-bit integer to 32-bit output
        end
    end

endmodule
