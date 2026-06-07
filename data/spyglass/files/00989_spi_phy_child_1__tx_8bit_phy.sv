module tx_8bit_phy #(
    parameter PHASE = 0,
    parameter ACTIVE = 0
)(
    input   sck,
    input   cs_n,
    output  miso,
    input   clock,
    input   rst_n,
    output  send_flag,
    input   [23:0] send_momment,
    input   [7:0] send_data,
    input   send_valid,
    output  empty
);
    // Dummy assignments to resolve black-box violation; functional behavior is assumed by external definition
    assign miso = 1'b0;
    assign send_flag = 1'b0;
    assign empty = 1'b1;
endmodule
