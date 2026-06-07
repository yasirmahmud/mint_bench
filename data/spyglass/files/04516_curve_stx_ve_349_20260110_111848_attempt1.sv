module curve_stx_ve_349_20260110_111848_attempt1 (
    input wire clk,
    input wire rst_n,
    input wire en,
    output reg [3:0] count_out
);

reg [3:0] i;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count_out <= 4'b0;
    end else if (en) begin
        for (i = 0; i < 10; i = i + 1) begin
            if (i == 5) begin
                break; // STX_VE_349 violation expected here
            end
            count_out <= i;
        end
    end
end

endmodule
