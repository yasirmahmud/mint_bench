module curve_starc05_2_2_3_3_20260111_154605_205081_w31260_attempt1 (
    input wire clk,
    input wire reset,
    input wire data_in_a,
    input wire data_in_b,
    output reg my_flop
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        my_flop <= 1'b0;
    end else begin
        my_flop <= data_in_a; // First assignment to my_flop
        my_flop <= data_in_b; // Second assignment to my_flop - This line triggers the violation
    end
end

endmodule
