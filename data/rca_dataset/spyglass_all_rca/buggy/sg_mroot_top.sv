module sg_mroot_top #(
    parameter int DATA_W = 32
) (
    output logic signature
);
    logic sig_a;
    logic sig_b;
    logic sig_c;

    sg_mroot_subsys_a #(
        .DATA_W(DATA_W)
    ) u_a (
        .signature(sig_a)
    );

    sg_mroot_subsys_b #(
        .DATA_W(DATA_W)
    ) u_b (
        .signature(sig_b)
    );

    sg_mroot_subsys_c #(
        .DATA_W(DATA_W)
    ) u_c (
        .signature(sig_c)
    );

    always_comb begin
        signature = sig_a ^ sig_b ^ sig_c;
    end
endmodule

