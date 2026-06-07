module curve_wrn_1021_20260111_180439_651707_w53504_attempt10 (
    input wire clk,
    input wire rst_n,
    input wire [7:0] data_in,
    output reg [7:0] data_out
);

    // Declare two distinct arrays, both with valid indices from 0 to 9.
    // Accessing index 10 for either array will be an out-of-bounds violation.
    reg [7:0] my_array_a[0:9]; 
    reg [7:0] my_array_b[0:9]; 

    // A simple index for valid array accesses to ensure array elements and signals are used.
    reg [3:0] current_valid_index; 

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out <= 8'd0;
            current_valid_index <= 4'd0;
            // Initialize array elements to avoid uninitialized value warnings
            for (integer i = 0; i < 10; i = i + 1) begin
                my_array_a[i] <= 8'd0;
                my_array_b[i] <= 8'd0;
            end
        end else begin
            // Normal operation: use the arrays and inputs/outputs to prevent unused warnings
            current_valid_index <= (current_valid_index == 4'd9) ? 4'd0 : current_valid_index + 4'd1;
            
            // Valid accesses to my_array_a and my_array_b to keep them 'used'
            my_array_a[current_valid_index] <= data_in; 
            my_array_b[current_valid_index] <= ~data_in; 

            // Use data_out to ensure it's driven and reads from the arrays
            data_out <= my_array_a[current_valid_index] ^ my_array_b[current_valid_index];

            // --- WRN_1021 violations begin here ---
            // These lines will trigger WRN_1021 because index 10 is out of range [0:9] for both arrays.
            // This approach generates two distinct WRN_1021 violations without other warnings
            // (like multiple drivers), as current_valid_index (0-9) never conflicts with constant 10.
            my_array_a[10] <= 8'hAA; // First occurrence of WRN_1021
            my_array_b[10] <= 8'hBB; // Second occurrence of WRN_1021
        end
    end

endmodule
