module curve_wrn_1021_20260112_004612_102327_w47152_attempt15 (
    input wire clk,
    input wire rst_n,
    input wire [7:0] in_data,
    output reg [7:0] out_data_a,
    output reg [7:0] out_data_b
);

    // Declare two register arrays, each with a permissible range of [0:0]
    // This small range makes it easy to create out-of-bounds access.
    reg [7:0] data_storage_a[0:0];
    reg [7:0] data_storage_b[0:0];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Initialize all elements and outputs to prevent X-propagation and ensure usage
            data_storage_a[0] <= 8'h00;
            data_storage_b[0] <= 8'h00;
            out_data_a <= 8'h00;
            out_data_b <= 8'h00;
        end else begin
            // Valid assignments to ensure the arrays are considered 'used' by synthesis
            // and their valid elements are updated.
            data_storage_a[0] <= in_data;
            data_storage_b[0] <= in_data;

            // First WRN_1021 violation: Array index 1 is out-of-bounds for data_storage_a[0:0]
            // The permissible range is [0:0], and 1 is clearly outside this range.
            data_storage_a[1] <= in_data + 8'h01; 

            // Second WRN_1021 violation: Array index 1 is out-of-bounds for data_storage_b[0:0]
            // Using a different array for the second violation ensures two distinct
            // WRN_1021 instances and avoids potential multiple driver warnings on a single element.
            // The index 1 is also out-of-bounds for data_storage_b with range [0:0].
            data_storage_b[1] <= in_data + 8'h02;

            // Assign valid array elements to outputs to ensure 'data_storage_a' and 'data_storage_b'
            // are read, preventing 'unused signal' warnings for the arrays themselves.
            out_data_a <= data_storage_a[0];
            out_data_b <= data_storage_b[0];
        end
    end

endmodule
