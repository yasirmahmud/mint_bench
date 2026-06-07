`timescale 1ns/1ps
`default_nettype none

module cpu1_irq_sync (
    input  wire clk,
    input  wire rst_n,
    input  wire irq_async,
    output wire irq_sync
);
    reg irq_meta_q;
    reg irq_sync_q;

    assign irq_sync = irq_sync_q;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            irq_meta_q <= 1'b0;
            irq_sync_q <= 1'b0;
        end else begin
            irq_meta_q <= irq_async;
            irq_sync_q <= irq_meta_q;
        end
    end
endmodule

`default_nettype wire
