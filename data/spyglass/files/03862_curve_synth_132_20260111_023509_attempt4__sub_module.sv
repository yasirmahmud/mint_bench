// sub_module definition (Verilog-2001 compliant)
module sub_module #(
    parameter DATA_BITS = 8 // Default value
) (
    input clk,
    input [DATA_BITS-1:0] in_data,
    output reg [DATA_BITS-1:0] out_data
);

    // Simple sequential logic to ensure out_data is driven
    always @(posedge clk) begin
        out_data <= in_data;
    end

endmodule
