module curve_wrn_1021_20260111_180439_651707_w53504_attempt9 (
    input wire clk,
    input wire rst_n,
    input wire [3:0] user_index_a, // This can be 0-15
    input wire [3:0] user_index_b, // This can be 0-15
    input wire control_select,     // Selects which violation path
    input wire [7:0] data_in,
    output reg [7:0] data_out
);

    reg [7:0] my_array[0:9]; // Valid indices 0 to 9. Requires 4 bits to address 0-9.

    reg [3:0] internal_index_counter; // A simple counter for valid access, 0-9
    reg [4:0] potential_bad_index_a;  // Can hold values up to 31.
    reg [4:0] potential_bad_index_b;  // Can hold values up to 31.

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out <= 8'd0;
            internal_index_counter <= 4'd0;
            potential_bad_index_a <= 5'd0;
            potential_bad_index_b <= 5'd0;
            // Initialize array elements to avoid uninitialized value warnings
            for (integer i = 0; i < 10; i = i + 1) begin
                my_array[i] <= 8'd0;
            end
        end else begin
            // Update a valid index for general array access and to use 'clk'
            internal_index_counter <= (internal_index_counter == 4'd9) ? 4'd0 : internal_index_counter + 4'd1;

            // Assign inputs to internal registers. user_index_a/b are [3:0], so potential_bad_index_a/b 
            // will take values from 0 to 15. The [4:0] width is just to accommodate potential values.
            potential_bad_index_a <= user_index_a;
            potential_bad_index_b <= user_index_b;

            // Regular array access to keep array and data_in/data_out alive and avoid unused warnings
            my_array[internal_index_counter] <= data_in;
            data_out <= my_array[internal_index_counter]; // Ensures data_out and my_array are read/written

            // --- WRN_1021 violations begin here ---
            // These assignments use indices that are dynamically derived. The inputs user_index_a/b
            // can range from 0-15. The array my_array has valid indices [0:9].
            // SpyGlass is expected to flag WRN_1021 because the index *can* be out of bounds (values 10-15).
            if (control_select) begin
                // First WRN_1021: Access with an index that is sometimes out of bounds.
                my_array[potential_bad_index_a] <= data_in + 8'd1; // WRN_1021 expected here
            end else begin
                // Second WRN_1021: Another access that is sometimes out of bounds.
                my_array[potential_bad_index_b] <= data_in + 8'd2; // WRN_1021 expected here
            end
        end
    end

endmodule
