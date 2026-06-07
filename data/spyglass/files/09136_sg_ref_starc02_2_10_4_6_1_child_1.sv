module star_c02_2_10_4_6_ex1(
    output signed [7:0] my_signal_out
);
    reg signed [7:0] my_signal = -5;

    assign my_signal_out = my_signal;

endmodule
