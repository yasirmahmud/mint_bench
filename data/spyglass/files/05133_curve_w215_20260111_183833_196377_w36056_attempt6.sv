module curve_w215_20260111_183833_196377_w36056_attempt6 (
    input wire [31:0] in_data,
    output reg        out_bit
);

    // Declare an integer variable
    integer my_int_variable;

    always @(*) begin
        // Assign an input to the integer variable
        my_int_variable = in_data;

        // Trigger W215: Inappropriate bit select for an integer variable
        out_bit = my_int_variable[0];
    end

endmodule
