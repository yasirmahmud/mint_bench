module sg_noise_top #(
    parameter int DATA_W = 32
) (
    output logic [DATA_W-1:0] debug_out,
    output logic              signature
);

    // ROOT BUG: TOP_W should be DATA_W (32), but is incorrectly set to 24.
    // This creates a cascade of dependent width-mismatch violations (W110) across the hierarchy.
    localparam int TOP_W = 24;

    logic [TOP_W-1:0] payload_src;
    logic [TOP_W-1:0] payload_after_probe;
    logic [TOP_W-1:0] payload_out;
    logic [      1:0] route_sel;
    logic             probe_parity;

    always_comb begin
        payload_src = {TOP_W{1'b1}};
        route_sel   = 2'd1;
    end

    sg_noise_probe #(
        .DATA_W(DATA_W)
    ) u_probe (
        .data_in (payload_src),
        .mode    (route_sel),
        .data_out(payload_after_probe),
        .parity  (probe_parity)
    );

    sg_noise_subsystem #(
        .WIDTH (TOP_W),
        .DATA_W(DATA_W)
    ) u_subsystem (
        .payload_in (payload_after_probe),
        .route_sel  ({route_sel[1], probe_parity}),
        .payload_out(payload_out)
    );

    always_comb begin
        signature = probe_parity ^ (^payload_out);
        if (TOP_W < DATA_W) begin
            debug_out = {{(DATA_W - TOP_W) {1'b0}}, payload_out};
        end else begin
            debug_out = payload_out;
        end
    end
endmodule
