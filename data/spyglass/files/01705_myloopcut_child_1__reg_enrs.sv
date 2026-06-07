module reg_enrs #(
    parameter WIDTH = 1,
    parameter RESET_VAL = 0,
    parameter string NAME = "default_name"
)(
    input clk,
    input rst,
    input en, // enable
    input [WIDTH-1 : 0] din,
    output reg [WIDTH-1 : 0] dout
);
always @(posedge clk or posedge rst) begin
    if (rst) begin
        dout <= RESET_VAL;
    end else if (en) begin
        dout <= din;
    end
end
endmodule
