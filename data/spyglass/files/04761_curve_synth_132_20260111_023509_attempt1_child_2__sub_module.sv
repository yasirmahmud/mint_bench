// sub_module definition
module sub_module #(
    parameter SIZE = 8 // Parameter to be referenced by the top module
) (
    input clk,
    input rst,
    input [SIZE-1:0] data_in,
    output [SIZE-1:0] data_out
);

    reg [SIZE-1:0] internal_data;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            internal_data <= {SIZE{1'b0}};
        end else begin
            internal_data <= data_in;
        end
    end

    assign data_out = internal_data;

endmodule
