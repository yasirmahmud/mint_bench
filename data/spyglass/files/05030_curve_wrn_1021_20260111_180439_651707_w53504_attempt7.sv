module curve_wrn_1021_20260111_180439_651707_w53504_attempt7 (
    input clk,
    input rst_n,
    input [7:0] in_data,
    output [7:0] out_data
);

    // Declare an array with valid indices from 0 to 1.
    reg [7:0] data_array[0:1]; // Valid indices: 0, 1
    reg [7:0] out_reg;
    reg [1:0] write_index; // This index will intentionally go out of bounds
    reg [1:0] read_index;  // This index will always stay within valid bounds

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset logic: Initialize all valid array elements and control registers
            data_array[0] <= 8'd0;
            data_array[1] <= 8'd0;
            out_reg <= 8'd0;
            write_index <= 2'd0;
            read_index <= 2'd0;
        end else begin
            // Increment write_index. Since it's 2 bits, it will cycle 0 -> 1 -> 2 -> 3 -> 0...
            // The value '2' is out of bounds for data_array[0:1].
            write_index <= write_index + 2'd1;

            // Increment read_index, ensuring it always stays within valid bounds (0 or 1).
            read_index <= read_index + 2'd1;
            if (read_index == 2'd2) begin // When it tries to go out of bounds, reset it.
                read_index <= 2'd0;
            end

            // Normal operation: Assign to a valid array element and read from another to ensure usage.
            data_array[read_index] <= in_data; 
            out_reg <= data_array[read_index];

            // --- WRN_1021 violations begin here ---
            // These violations occur when 'write_index' becomes '2',
            // which is out of range for 'data_array[0:1]'.
            if (write_index == 2'd2) begin 
                data_array[write_index] <= in_data;      // First WRN_1021 violation
                data_array[write_index] <= 8'hAA;       // Second WRN_1021 violation
            end
            // --- WRN_1021 violations end here ---
        end
    end

    assign out_data = out_reg;

endmodule
