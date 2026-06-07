module top_module (
    input top_in_0,
    input top_in_1,
    output top_out_0,
    output top_out_1
);

    wire sub_out_0;
    wire sub_out_1;

    sub_module i_sub_module_0 (
        .data_in_s  (top_in_0),
        .data_out_s (sub_out_0),
        .in         (top_in_0)
    );

    sub_module i_sub_module_1 (
        .data_in_s  (top_in_1),
        .data_out_s (sub_out_1),
        .in         (top_in_1)
    );

    assign top_out_0 = sub_out_0;
    assign top_out_1 = sub_out_1;

endmodule
