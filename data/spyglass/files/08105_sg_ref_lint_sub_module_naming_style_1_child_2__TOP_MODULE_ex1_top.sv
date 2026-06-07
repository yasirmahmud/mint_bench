module TOP_MODULE_ex1_top();
    wire sub_module_in;
    wire sub_module_out;

    SUB_MODULE U1 (
        .in_val  (sub_module_in),
        .out_val (sub_module_out)
    );
endmodule
