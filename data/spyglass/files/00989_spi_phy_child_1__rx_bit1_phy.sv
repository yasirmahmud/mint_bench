module rx_bit1_phy #(
    parameter PHASE = 0,
    parameter ACTIVE = 0
)(
    input   sck,
    input   cs_n,
    input   mosi,
    input   clock,
    input   rst_n,
    output  start,
    output  finish,
    output  rx_data,
    output  rx_valid
);
    // Dummy assignments to resolve black-box violation; functional behavior is assumed by external definition
    assign start = 1'b0;
    assign finish = 1'b0;
    assign rx_data = 1'b0;
    assign rx_valid = 1'b0;
endmodule
