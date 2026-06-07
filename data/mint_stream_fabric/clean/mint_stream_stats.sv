`default_nettype none

module mint_stream_stats #(
    parameter int unsigned USER_W = 1,
    parameter int unsigned CNT_W  = 32
) (
    input  logic              clk,
    input  logic              rst_n,

    input  logic              tvalid,
    input  logic              tready,
    input  logic              tlast,
    input  logic [USER_W-1:0] tuser,

    output logic [CNT_W-1:0]  beat_count,
    output logic [CNT_W-1:0]  packet_count,
    output logic [CNT_W-1:0]  src0_beat_count,
    output logic [CNT_W-1:0]  src1_beat_count,
    output logic [CNT_W-1:0]  src0_packet_count,
    output logic [CNT_W-1:0]  src1_packet_count
);
    logic fire;

    assign fire = tvalid && tready;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            beat_count <= '0;
            packet_count <= '0;
            src0_beat_count <= '0;
            src1_beat_count <= '0;
            src0_packet_count <= '0;
            src1_packet_count <= '0;
        end else if (fire) begin
            beat_count <= beat_count + {{(CNT_W-1){1'b0}}, 1'b1};

            if (tuser[0] == 1'b0) begin
                src0_beat_count <= src0_beat_count + {{(CNT_W-1){1'b0}}, 1'b1};
            end else begin
                src1_beat_count <= src1_beat_count + {{(CNT_W-1){1'b0}}, 1'b1};
            end

            if (tlast) begin
                packet_count <= packet_count + {{(CNT_W-1){1'b0}}, 1'b1};

                if (tuser[0] == 1'b0) begin
                    src0_packet_count <= src0_packet_count + {{(CNT_W-1){1'b0}}, 1'b1};
                end else begin
                    src1_packet_count <= src1_packet_count + {{(CNT_W-1){1'b0}}, 1'b1};
                end
            end
        end
    end
endmodule

`default_nettype wire

