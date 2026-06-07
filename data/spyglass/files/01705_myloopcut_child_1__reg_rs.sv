module reg_rs #(
    parameter WIDTH = 1,
    parameter RESET_VAL = 0
)(
    input clk,
    input rst,
    input [WIDTH-1 : 0] din,
    output reg [WIDTH-1 : 0] dout
);
always @(posedge clk or posedge rst) begin
    if (rst) begin
        dout <= RESET_VAL;
    end else begin
        dout <= din;
    end
end
endmodule
