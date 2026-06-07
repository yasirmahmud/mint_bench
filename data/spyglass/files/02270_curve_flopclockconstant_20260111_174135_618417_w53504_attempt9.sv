module curve_flopclockconstant_20260111_174135_618417_w53504_attempt9 (
    input data_in1,
    input data_in2,
    output reg q1,
    output reg q2
);

    // Single wire tied to a constant '0' for the clock signal
    wire constant_gnd_clk = 1'b0;

    // First flip-flop clocked by the constant '0' signal
    always @(posedge constant_gnd_clk) begin
        q1 <= data_in1;
    end

    // Second flip-flop also clocked by the constant '0' signal
    always @(posedge constant_gnd_clk) begin
        q2 <= data_in2;
    end

endmodule
