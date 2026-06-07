module curve_flopclockconstant_20260111_174135_618417_w53504_attempt10 (
    input data_input1,
    input data_input2,
    output reg flop_out1,
    output reg flop_out2
);

    // Declare a wire to be used as a constant clock
    wire constant_low_clk;

    // Explicitly assign the wire to a constant '0', tying it low
    assign constant_low_clk = 1'b0;

    // First flip-flop clocked by the constant '0' signal
    always @(posedge constant_low_clk) begin
        flop_out1 <= data_input1;
    end

    // Second flip-flop also clocked by the constant '0' signal
    always @(posedge constant_low_clk) begin
        flop_out2 <= data_input2;
    end

endmodule
