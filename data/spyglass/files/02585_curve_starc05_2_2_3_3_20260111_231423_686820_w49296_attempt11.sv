module curve_starc05_2_2_3_3_20260111_231423_686820_w49296_attempt11 (
    input wire clk,
    input wire rst_n,
    input wire data_val1,
    input wire data_val2,
    output reg output_flop
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        output_flop <= 1'b0;
    end else begin
        // First assignment to output_flop
        output_flop <= data_val1;

        // Second assignment to output_flop within the same always block
        // This directly causes the STARC05-2.2.3.3 violation.
        output_flop <= data_val2;
    end
end

endmodule
