// sub_module definition
module sub_module #(
    parameter int DATA_WIDTH = 8 // Correctly declare parameter in module header
) (
    input clk,
    input rst,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            data_out <= {DATA_WIDTH{1'b0}};
        end else begin
            data_out <= data_in;
        end
    end

endmodule
