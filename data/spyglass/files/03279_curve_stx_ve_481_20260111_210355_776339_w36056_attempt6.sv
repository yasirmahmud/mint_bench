module curve_stx_ve_481_20260111_210355_776339_w36056_attempt6 (
    output reg dummy_signal
);

// The 'else' keyword cannot appear without a preceding 'if' statement.
// This directly causes a syntax error related to the illegal use of 'else'.
always @(*) begin
    else begin
        dummy_signal = 1'b0;
    end
end

endmodule
