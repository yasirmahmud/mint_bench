module curve_synth_5059_20260110_171921_attempt7 (
    input [3:0] data_in,
    output reg flag_out
);

always @* begin
    if (data_in !== 4'b1x01) begin
        flag_out = 1'b1;
    end else begin
        flag_out = 1'b0;
    end
end

endmodule
