module curve_stx_ve_481_20260111_210355_776339_w36056_attempt7 (
    input clk,
    output reg dummy_out
);

always @(posedge clk) begin
    dummy_out <= 1'b0;
end

// The 'else' keyword here is illegal as it does not immediately follow an 'if' statement.
// This directly triggers STX_VE_481.
else begin
    dummy_out <= 1'b1;
end

endmodule
