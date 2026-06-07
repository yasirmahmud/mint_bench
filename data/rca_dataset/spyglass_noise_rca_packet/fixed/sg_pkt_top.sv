module sg_pkt_top #(
    parameter int DATA_W = 32
) (
    output logic [DATA_W-1:0] debug_out,
    output logic              signature
);

    // FIX: Use the intended design-wide payload width (DATA_W).
    localparam int BUS_W = DATA_W;

    logic [BUS_W-1:0] payload_src;
    logic [BUS_W-1:0] payload_after_probe;
    logic [BUS_W-1:0] payload_out;
    logic [      1:0] route_sel;
    logic             probe_parity;

    always_comb begin
        payload_src = {BUS_W{1'b1}};
        route_sel   = 2'd2;
    end

    sg_pkt_probe #(
        .DATA_W(DATA_W)
    ) u_probe (
        .data_in (payload_src),
        .mode    (route_sel),
        .data_out(payload_after_probe),
        .parity  (probe_parity)
    );

    sg_pkt_fabric #(
        .WIDTH (BUS_W),
        .DATA_W(DATA_W)
    ) u_fabric (
        .payload_in (payload_after_probe),
        .route_sel  ({route_sel[1], probe_parity}),
        .payload_out(payload_out)
    );

    always_comb begin
        signature = probe_parity ^ (^payload_out);
        debug_out = {{(DATA_W - BUS_W){1'b0}}, payload_out};
    end
endmodule
