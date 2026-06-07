module curve_wrn_1021_20260112_004612_102327_w47152_attempt14 (
    input wire clk,
    input wire rst_n,
    input wire [7:0] in_data,
    output reg [7:0] out_valid_data
);

    // Declare a register array with a permissible range of [0:3]
    reg [7:0] data_storage[0:3];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Initialize a valid array element and output to prevent X-propagation and ensure usage
            data_storage[0] <= 8'h00;
            out_valid_data <= 8'h00;
        end else begin
            // First WRN_1021 violation: Array index 4 is out-of-bounds for the declared range [0:3].
            data_storage[4] <= in_data;

            // Second WRN_1021 violation: Array index 5 is out-of-bounds for the declared range [0:3].
            // Using a different out-of-bounds index ensures two distinct WRN_1021 violations
            // without generating multiple driver warnings on the same element.
            data_storage[5] <= in_data + 8'h01;

            // Assign a valid array element to the output to ensure data_storage is 'used'
            // and out_valid_data is driven, avoiding 'unused signal' warnings.
            out_valid_data <= data_storage[0];
        end
    end

endmodule
