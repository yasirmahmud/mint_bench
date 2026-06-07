module curve_w240_20260111_160401_066985_w30032_attempt1 (
    input clk,
    input rst_n,
    input [7:0] data_in,
    output reg [7:0] data_out
);

// The 'rst_n' input is declared but not read or used within the module,
// which triggers the W240 violation.
always @(posedge clk) begin
    data_out <= data_in;
end

endmodule
