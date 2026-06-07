module curve_stx_ve_643_20260111_201206_241403_w37940_attempt8 (
    data_in,
    data_out,
    enable
);

    input [3:0] data_in;
    output [3:0] data_out;
    input enable; // Added direction declaration for 'enable'

    assign data_out = data_in;

endmodule
