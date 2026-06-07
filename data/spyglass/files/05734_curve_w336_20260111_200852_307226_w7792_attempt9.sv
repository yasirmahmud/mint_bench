module curve_w336_20260111_200852_307226_w7792_attempt9 (
    input clk,
    input [3:0] data_in,
    output reg [3:0] data_out
);

// This 'always' block infers a flip-flop for 'data_out'.
// The blocking assignment '=' to 'data_out' inside this sequential block
// triggers the W336 violation.
always @(posedge clk) begin
    data_out = data_in; // W336: Blocking assignment in a flip-flop inferred sequential block
end

endmodule
