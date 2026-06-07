module curve_wrn_1021_20260111_180439_651707_w53504_attempt6 (
    input clk,
    input rst_n,
    input [7:0] in_data,
    output [7:0] out_data
);

    // Declare an array with valid indices from 0 to 9.
    reg [7:0] data_array[0:9];
    reg [7:0] out_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset logic to initialize registers and avoid unused signal warnings
            data_array[0] <= 8'd0;
            data_array[1] <= 8'd0;
            out_reg <= 8'd0;
        end else begin
            // --- WRN_1021 violations begin here ---
            // First violation: Accessing index 10, which is out of bounds for data_array[0:9]
            data_array[10] <= in_data;
            // Second violation: Another access to index 10, also out of bounds
            data_array[10] <= 8'd0;
            // --- WRN_1021 violations end here ---
            
            // Use a valid index to avoid unused signal for another array element
            out_reg <= data_array[9];
        end
    end

    assign out_data = out_reg;

endmodule
