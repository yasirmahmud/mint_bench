module curve_w336_20260111_200852_307226_w7792_attempt10 (
    input clk,
    input enable,
    output reg [7:0] my_counter
);

// This 'always' block infers a flip-flop for 'my_counter'.
// The blocking assignment '=' to 'my_counter' inside this sequential block
// triggers the W336 violation.
always @(posedge clk) begin
    if (enable) begin
        my_counter = my_counter + 8'd1; // W336: Blocking assignment in a flip-flop inferred sequential block
    end
end

endmodule
