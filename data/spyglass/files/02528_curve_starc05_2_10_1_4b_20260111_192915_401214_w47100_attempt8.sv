module curve_starc05_2_10_1_4b_20260111_192915_401214_w47100_attempt8 (
    input wire [3:0] data_in,
    output reg        flag_out
);

    always @* begin
        if (data_in === 4'b10X1) begin // STARC05-2.10.1.4b violation: Signal compared with value containing x
            flag_out = 1'b1;
        end else begin
            flag_out = 1'b0;
        end
    end

endmodule
