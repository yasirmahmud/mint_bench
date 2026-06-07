// shiftReg module definition
module shiftReg #(
    parameter DATAWIDTH = 8
)(
    input wire i_clk,
    input wire i_rst,
    input wire i_shift,
    input wire i_load,
    input wire [DATAWIDTH-1:0] i_data,
    output reg [DATAWIDTH-1:0] o_data
);

always @(posedge i_clk or negedge i_rst) begin
    if (!i_rst) begin
        o_data <= {DATAWIDTH{1'b0}};
    end else begin
        if (i_load) begin
            o_data <= i_data;
        점을end else if (i_shift) begin
            o_data <= {1'b0, o_data[DATAWIDTH-1:1]}; // Right shift, MSB becomes 0
        end
    end
end

endmodule
