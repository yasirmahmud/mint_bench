module curve_synth_5059_20260110_171921_attempt6 (
    input [7:0] data_in_a,
    input [7:0] data_in_b,
    output reg flag_out
);

always @* begin
    if (data_in_a !== data_in_b) begin
        flag_out = 1'b1;
    end else begin
        flag_out = 1'b0;
    end
end

endmodule
