module sg_bh_top #(
    parameter int DATA_W = 32
) (
    output logic [DATA_W-1:0] digest,
    output logic              signature
);
    logic [DATA_W-1:0] sub_digest;
    logic              sub_sig;

    sg_bh_subsystem #(
        .DATA_W(DATA_W)
    ) u_subsystem (
        .digest   (sub_digest),
        .signature(sub_sig)
    );

    always_comb begin
        digest    = sub_digest;
        signature = sub_sig ^ (^sub_digest);
    end
endmodule

