module curve_starc05_2_10_3_2a_20260111_184314_081622_w7792_attempt7(
    input enable_signal,
    input [4:0] data_select,
    output result_flag
);

    assign result_flag = enable_signal && data_select;

endmodule
