module curve_w336_20260111_231742_160448_w38092_attempt11 (
    input clk,
    input rst_n,
    input [7:0] data_in,
    output [7:0] data_out
);

reg [7:0] data_register;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_register <= 8'd0;
    end else begin
        data_register = data_in; // W336: Blocking assignment in a flip-flop inferred sequential block
    end
end

assign data_out = data_register;

endmodule
