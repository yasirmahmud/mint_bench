module rx_8bit_from_phy (
    input   clock,
    input   rst_n,
    input   start,
    input   finish,
    input   rx_data,
    input   rx_valid,
    output  stream_sof,
    output  [7:0] stream_data,
    output  stream_vld,
    output  stream_eof
);
    // Dummy assignments to resolve black-box violation; functional behavior is assumed by external definition
    assign stream_sof = 1'b0;
    assign stream_data = 8'h00;
    assign stream_vld = 1'b0;
    assign stream_eof = 1'b0;
endmodule
