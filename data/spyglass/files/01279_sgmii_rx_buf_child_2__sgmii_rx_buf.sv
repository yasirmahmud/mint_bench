module sgmii_rx_buf
(
    input clk_125mhz,
    input rst,

    input tbi_rx_clk,

    input sgmii_autoneg_done,
    input [7:0] rx_byte,
    input rx_is_k,
    
    output [7:0] gmii_rxd,
    output gmii_rx_dv,
    output gmii_rx_err
);

    //
    // Skip data (non-k) bytes after any BC command
    //

    reg skip_next;
    reg pkt_vld;
    reg pkt_err;
    
    wire k_idle = rx_is_k && (rx_byte == 8'hBC);
    // Removed 'k_cext' as it was set but not read (SpyGlass W528 violation in original design).
    // wire k_cext = rx_is_k && (rx_byte == 8'hF7);
    wire k_sop = rx_is_k && (rx_byte == 8'hFB);
    wire k_eop = rx_is_k && (rx_byte == 8'hFD);
    wire k_err = rx_is_k && (rx_byte == 8'hFE);
    
    always @ (posedge tbi_rx_clk or posedge rst)
        if (rst)
            pkt_vld <= 1'b0;
        else if (!sgmii_autoneg_done)
            pkt_vld <= 1'b0;
        else
            pkt_vld <= (pkt_vld || k_sop) && !k_eop && !k_idle;
            
    //
    // RX buffer
    //
    
    wire [8:0] fifo_in = {k_err, rx_byte};
    wire fifo_push = pkt_vld && !k_eop && !k_idle;
    wire [8:0] fifo_out;
    wire fifo_empty;

    // Wire to connect the unused 'full' output of sgmii_fifo.
    // This resolves SpyGlass W287b violation.
    wire unused_fifo_full;
    
    sgmii_fifo sgmii_fifo
    (
        .rst_in(rst),
        .clk_in(tbi_rx_clk),
        .clk_out(clk_125mhz),

        .fifo_in(fifo_in),
        .push(fifo_push),
        .full(unused_fifo_full), // Connect to dummy wire to resolve W287b

        .fifo_out(fifo_out),
        .pop(!fifo_empty),
        .empty(fifo_empty)
    );
    
    //
    // GMII out
    //
    
    assign gmii_rxd = (!fifo_empty) ? fifo_out[7:0] : 8'd0;
    assign gmii_rx_dv = !fifo_empty;
    assign gmii_rx_err = (!fifo_empty) ? fifo_out[8] : 1'b0;
    
endmodule
