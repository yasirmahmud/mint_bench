module curve_w336_20260111_200852_307226_w7792_attempt8 (
    input clk,
    input enable,
    output reg [7:0] out_val
);

reg [7:0] counter_reg;

// This always block infers a flip-flop for counter_reg.
// The blocking assignment '=' for counter_reg inside this block
// triggers the W336 violation.
always @(posedge clk) begin
    if (enable) begin
        counter_reg = counter_reg + 8'd1; // W336: Blocking assignment in a flip-flop inferred sequential block
    end
end

assign out_val = counter_reg;

endmodule
