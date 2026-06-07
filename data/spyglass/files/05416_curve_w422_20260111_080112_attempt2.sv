module curve_w422_20260111_080112_attempt2 (
    input clk1,
    input clk2,
    input data_in,
    output reg data_out
);

always @(posedge clk1 or posedge clk2) begin
    data_out <= data_in;
end

endmodule
