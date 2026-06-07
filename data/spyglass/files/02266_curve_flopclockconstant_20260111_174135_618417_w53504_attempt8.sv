module curve_flopclockconstant_20260111_174135_618417_w53504_attempt8 (
    input data_in_a,
    input data_in_b,
    output reg reg_out_a,
    output reg reg_out_b
);

    // Declare a wire tied to a constant '0' for the first clock signal
    wire constant_clock_gnd_a = 1'b0;

    // Declare another wire tied to a constant '0' for the second clock signal
    wire constant_clock_gnd_b = 1'b0;

    // First flip-flop clocked by the first constant '0' signal
    always @(posedge constant_clock_gnd_a) begin
        reg_out_a <= data_in_a;
    end

    // Second flip-flop clocked by the second constant '0' signal
    always @(posedge constant_clock_gnd_b) begin
        reg_out_b <= data_in_b;
    end

endmodule
