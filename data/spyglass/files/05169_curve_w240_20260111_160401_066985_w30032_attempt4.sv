module curve_w240_20260111_160401_066985_w30032_attempt4 (
    input clk,
    input rst, // This input is declared but not read, triggering W240.
    input [7:0] data_in,
    output reg [7:0] data_out
);

// A simple D-flop to ensure clk, data_in, and data_out are used.
always @(posedge clk) begin
    data_out <= data_in;
end

endmodule
