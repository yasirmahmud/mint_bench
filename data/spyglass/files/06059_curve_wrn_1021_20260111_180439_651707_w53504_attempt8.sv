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

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset logic: Initialize all valid array elements and control registers
            for (index_reg = 0; index_reg < 10; index_reg = index_reg + 1) begin
                data_storage[index_reg] <= 8'd0;
            end
            out_reg <= 8'd0;
            control_flag <= 1'b0;
            index_reg <= 4'd0; // Reset for index_reg itself
        end else begin
            // Increment index_reg and keep it within 0-9 for valid array access
            index_reg <= index_reg + 4'd1;
            if (index_reg == 4'd9) begin
                index_reg <= 4'd0;
            end

            // Normal operation: Assign to a valid array element and read from another to ensure usage.
            data_storage[index_reg] <= in_data; // Valid access, uses in_data
            out_reg <= data_storage[index_reg]; // Valid access, uses data_storage

            // --- WRN_1021 violations begin here ---
            // The index '10' is out-of-bounds for data_storage[0:9].
            // These assignments are in mutually exclusive branches to avoid W415a (multiple assignments).
            if (in_data[0] == 1'b1) begin
                data_storage[10] <= 8'hAA; // First WRN_1021 violation (index 10 is out of range [0:9])
                control_flag <= 1'b1;     // Assign to control_flag in this branch
            end else begin
                data_storage[10] <= 8'hBB; // Second WRN_1021 violation (index 10 is out of range [0:9])
                control_flag <= 1'b0;     // Assign to control_flag in this branch
            end
            // --- WRN_1021 violations end here ---
        end
    end

    // Connect the output
    assign out_data = out_reg;

endmodule
