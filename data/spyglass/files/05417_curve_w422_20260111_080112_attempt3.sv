module curve_w422_20260111_080112_attempt3 (
    input clk,
    input enable_signal,
    input data_in,
    output reg data_out
);

always @(posedge clk or posedge enable_signal) begin
    data_out <= data_in;
end

endmodule
