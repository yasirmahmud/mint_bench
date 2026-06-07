module curve_wrn_1021_20260111_180439_651707_w53504_attempt8 (
    input clk,
    input rst_n,
    input [7:0] in_data,
    output [7:0] out_data
);

    // Declare an array with valid indices from 0 to 9.
    reg [7:0] data_storage[0:9];

    // Other registers to ensure usage and avoid warnings like unused signals
    reg [7:0] out_reg;
    reg control_flag;
    reg [3:0] index_reg; // An index that will be within bounds for normal operations

    // Local integer for for-loop to resolve W480 and STARC05-2.11.3.1 related issues
    integer i; // Fix W480: Loop index 'index_reg' is not of type integer

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset logic: Initialize all valid array elements and control registers
            for (i = 0; i < 10; i = i + 1) begin // Use integer 'i' for loop counter
                data_storage[i] <= 8'd0;
            end
            out_reg <= 8'd0;
            control_flag <= 1'b0;
            index_reg <= 4'd0; // Reset for index_reg itself
        end else begin
            // Increment index_reg and keep it within 0-9 for valid array access
            // Fix W415a (multiple assignments to index_reg) and STARC05-2.11.3.1 (combinational and sequential FSM parts)
            if (index_reg == 4'd9) begin
                index_reg <= 4'd0;
            end else begin
                index_reg <= index_reg + 4'd1;
            end

            // Normal operation: Assign to a valid array element and read from another to ensure usage.
            data_storage[index_reg] <= in_data; // Valid access, uses in_data

            // To resolve W528 (control_flag set but not read), we make it affect out_reg.
            // This is a minimal functional change to the MSB of out_data to ensure usage.
            out_reg <= data_storage[index_reg] ^ {control_flag, 7'b0}; // Valid access, uses data_storage and control_flag

            // --- WRN_1021 violations begin here ---
            // The index '10' is out-of-bounds for data_storage[0:9].
            // Fix: Change '10' to a valid index, e.g., '9', to resolve SYNTH_5255 and WRN_1021.
            // These assignments are in mutually exclusive branches to avoid W415a (multiple assignments).
            if (in_data[0] == 1'b1) begin
                data_storage[9] <= 8'hAA; // First WRN_1021 violation fixed (index 9 is in range [0:9])
                control_flag <= 1'b1;     // Assign to control_flag in this branch
            end else begin
                data_storage[9] <= 8'hBB; // Second WRN_1021 violation fixed (index 9 is in range [0:9])
                control_flag <= 1'b0;     // Assign to control_flag in this branch
            end
            // --- WRN_1021 violations end here ---
        end
    end

    // Connect the output
    assign out_data = out_reg;

endmodule
