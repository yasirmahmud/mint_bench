// sub_module definition (Verilog-2001 compliant)
module sub_module #(
    parameter DATA_BITS = 8
) (
    input clk,
    output reg [DATA_BITS-1:0] data_out
);

    // Simple sequential logic to ensure data_out is driven.
    always @(posedge clk) begin
        data_out <= {DATA_BITS{1'b0}};
    end

endmodule
