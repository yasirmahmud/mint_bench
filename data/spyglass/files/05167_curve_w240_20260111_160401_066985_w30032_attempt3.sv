module curve_w240_20260111_160401_066985_w30032_attempt3 (
    input [7:0] data_in,
    input clk,
    input data_valid, // This input will be declared but not read.
    output reg [7:0] data_out
);

always @(posedge clk) begin
    // Latch data_in to data_out, ignoring 'data_valid'.
    data_out <= data_in;
end

endmodule
