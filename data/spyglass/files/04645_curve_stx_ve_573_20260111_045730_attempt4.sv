module curve_stx_ve_573_20260111_045730_attempt4 (
    input wire clk,
    input wire rst_n,
    input wire in_data,
    output reg out_data
);

reg [7:0] count_reg // Semicolon missing here
reg enable_reg;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count_reg <= 8'd0;
        enable_reg <= 1'b0;
        out_data <= 1'b0;
    end else begin
        if (enable_reg) begin
            count_reg <= count_reg + 8'd1;
            out_data <= in_data;
        end else begin
            count_reg <= 8'd0;
            out_data <= 1'b0;
        end
        if (in_data) begin
            enable_reg <= 1'b1;
        end else begin
            enable_reg <= 1'b0;
        end
    end
end

endmodule
