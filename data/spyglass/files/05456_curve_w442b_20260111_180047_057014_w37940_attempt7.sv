module curve_w442b_20260111_180047_057014_w37940_attempt7 (
    input clk,
    input async_reset_in,
    input data_input_val,
    output reg output_reg_q
);

    // W442b violation: In asynchronous reset always block, a comparison is made to a
    // non-constant expression (data_input_val) in the reset condition.
    always @(posedge clk or posedge async_reset_in) begin
        if (async_reset_in == data_input_val) begin
            output_reg_q <= 1'b0;
        end else begin
            output_reg_q <= data_input_val;
        end
    end

endmodule
