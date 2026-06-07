module curve_stx_ve_569_20260111_224802_798826_w15680_attempt11 (
    input clk,
    input rst_n,
    input data_in,
    output reg data_out
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_out <= 1'b0;
    end else begin
        // The 'end' keyword for the following 'if (data_in) begin' block is missing.
        if (data_in) begin
            data_out <= 1'b1;
        // The parser expects an 'end' here to close 'if (data_in) begin'.
        // Without it, the 'else begin' block remains unclosed.
    end
end
endmodule
