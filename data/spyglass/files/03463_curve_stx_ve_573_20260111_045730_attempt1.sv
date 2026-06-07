module curve_stx_ve_573_20260111_045730_attempt1 (
    input wire clk,
    input wire rst_n,
    input wire din,
    output reg dout
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        dout <= 1'b0;
    end else begin
        dout <= din // Semicolon missing here
    end
end

endmodule
