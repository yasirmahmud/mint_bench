module multiple_clocks_2 (
    input clk_a,
    input clk_b,
    input rst_n,
    input data_in,
    output reg data_out
);

always @(posedge clk_a or negedge rst_n) begin
    if (!rst_n) begin
        data_out <= 1'b0;
    end else begin
        data_out <= data_in;
    end
end

endmodule
