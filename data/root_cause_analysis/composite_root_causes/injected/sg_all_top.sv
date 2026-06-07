module sg_all_top #(
    parameter int DATA_W = 32
) (
    output logic [DATA_W-1:0] noise_debug_out,
    output logic              signature
);
    logic [DATA_W-1:0] bh_digest;
    logic              bh_signature;
    logic              noise_signature;
    logic              mroot_signature;

    // Blackhole / unresolved hierarchy scenario (root bug in sg_bh_subsystem.sv).
    sg_bh_subsystem #(
        .DATA_W(DATA_W)
    ) u_bh (
        .digest   (bh_digest),
        .signature(bh_signature)
    );

    // Single-root width mismatch noise scenario (root bug in sg_noise_top.sv).
    sg_noise_top #(
        .DATA_W(DATA_W)
    ) u_noise (
        .debug_out(noise_debug_out),
        .signature(noise_signature)
    );

    // Multi-root width mismatch scenario (3 independent roots in sg_mroot_subsys_*.sv).
    sg_mroot_top #(
        .DATA_W(DATA_W)
    ) u_mroot (
        .signature(mroot_signature)
    );

    always_comb begin
        signature = bh_signature ^ noise_signature ^ mroot_signature ^ (^bh_digest);
    end
endmodule
