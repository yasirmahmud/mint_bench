module curve_wrn_1021_20260111_220720_686432_w32456_attempt11 (
    input wire clk,
    input wire rst,
    input wire [7:0] in_data,
    output reg [7:0] out_data
);

    // Declare a 4-element array, valid indices are [0] to [3]
    reg [7:0] my_array_storage [3:0];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            my_array_storage[0] <= 8'h00;
            out_data <= 8'h00;
        end else begin
            // First WRN_1021 violation: Array index 4 is out of bounds for the declared range [3:0]
            my_array_storage[4] <= in_data; 

            // Second WRN_1021 violation: Array index 5 is out of bounds for the declared range [3:0]
            // By using a different out-of-bounds index, we avoid multiple driver warnings on a single element.
            my_array_storage[5] <= 8'hFF; 

            // Assign a valid array element to the output to avoid 'unused signal' warnings
            out_data <= my_array_storage[0]; 
        end
    end

endmodule
