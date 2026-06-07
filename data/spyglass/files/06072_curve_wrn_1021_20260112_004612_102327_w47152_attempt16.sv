module curve_wrn_1021_20260112_004612_102327_w47152_attempt16 (
    input wire clk,
    input wire rst_n,
    input wire [7:0] in_data,
    output reg [7:0] out_data_a,
    output reg [7:0] out_data_b
);

    // Declare two register arrays, each with a permissible range of [0:9]
    reg [7:0] data_a[0:9];
    reg [7:0] data_b[0:9];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Initialize all elements to prevent X-propagation and ensure usage during reset
            for (integer i = 0; i < 10; i = i + 1) begin
                data_a[i] <= 8'h00;
                data_b[i] <= 8'h00;
            end
            out_data_a <= 8'h00;
            out_data_b <= 8'h00;
        end else begin
            // Valid assignments to ensure the arrays are considered 'used' by synthesis
            // and their valid elements are updated in the operational phase.
            data_a[0] <= in_data;
            data_b[0] <= in_data + 8'h01; // Using a slightly different value

            // First WRN_1021 violation: Array index 10 is out-of-bounds for data_a[0:9]
            // The permissible range is [0:9], and 10 is clearly outside this range.
            data_a[10] <= 8'hAA;

            // Second WRN_1021 violation: Array index 10 is out-of-bounds for data_b[0:9]
            // Using a different array for the second violation ensures two distinct
            // WRN_1021 instances and avoids potential multiple driver warnings on a single element.
            data_b[10] <= 8'hBB;

            // Assign valid array elements to outputs to ensure 'data_a' and 'data_b'
            // are read, preventing 'unused signal' warnings for the arrays themselves.
            out_data_a <= data_a[0];
            out_data_b <= data_b[0];
        end
    end

endmodule
