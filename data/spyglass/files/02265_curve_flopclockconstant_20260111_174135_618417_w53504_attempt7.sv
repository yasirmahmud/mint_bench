module curve_flopclockconstant_20260111_174135_618417_w53504_attempt7 (
    input data_in_a,
    input data_in_b,
    output reg reg_out_a,
    output reg reg_out_b
);

    // Declare a wire tied to a constant '0' for the clock signal
    wire constant_clock_gnd = 1'b0;

    // First flip-flop clocked by the constant '0' signal
    always @(posedge constant_clock_gnd) begin
        reg_out_a <= data_in_a;
    end

    // Second flip-flop also clocked by the constant '0' signal
    always @(posedge constant_clock_gnd) begin
        reg_out_b <= data_in_b;
    end

endmodule
