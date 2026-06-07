module curve_synth_5255_20260111_190511_281205_w36056_attempt8 (
    input [7:0] data_source,
    output      result_out
);

    wire [7:0] my_vector;

    assign my_vector = data_source;

    assign result_out = my_vector[31] | my_vector[0];

endmodule
