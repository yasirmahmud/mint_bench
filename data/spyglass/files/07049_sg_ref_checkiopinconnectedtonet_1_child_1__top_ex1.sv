module top_ex1 (
    input in_a_top,
    output out_z_top
);
    my_cell u_inst (
        .in_a (in_a_top),
        .out_z (out_z_top)
    );
endmodule
