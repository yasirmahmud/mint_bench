module curve_elab_3519_20260111_142445_attempt3 (
    input clk,
    input rst,
    input data_in_dff,
    input data_in_mux0,
    input data_in_mux1,
    input sel_mux,
    output dff_out_signal,
    output mux_out_signal
);

    // This 'reg' is named M0. The rule states: "The register in the always block also gets elaborated as M0."
    reg M0;

    always @(posedge clk or posedge rst) begin
        if (rst)
            M0 <= 1'b0;
        else
            M0 <= data_in_dff;
    end

    assign dff_out_signal = M0;

    // This MUX instance is also named M0. The rule states: "That conflicts with the MUX instance name"
    simple_mux M0 (
        .i0(data_in_mux0),
        .i1(data_in_mux1),
        .sel(sel_mux),
        .out_data(mux_out_signal)
    );

endmodule
