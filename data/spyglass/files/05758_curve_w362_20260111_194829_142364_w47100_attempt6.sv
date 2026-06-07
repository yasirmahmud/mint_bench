module curve_w362_20260111_194829_142364_w47100_attempt6 (
    input [7:0] data_in,
    input [31:0] rmax,
    output reg result
);

    always @(*) begin
        if (data_in > rmax) begin // W362 violation: width mismatch for operator (>)
            result = 1'b1;
        end else begin
            result = 1'b0;
        end
    end

endmodule
