module curve_stx_ve_643_20260111_201206_241403_w37940_attempt6 (
    clk,
    rst_n,
    data_in,
    gray,
    data_out
);

    input clk;
    input rst_n;
    input data_in;
    // Port 'gray' is listed but its direction (input/output/inout) is not declared.
    output data_out;

    assign data_out = data_in; // Minimal logic to avoid unused signal warnings

endmodule
