`default_nettype none

module mint_stream_merge2 #(
    parameter int unsigned DATA_W = 32
) (
    input  logic clk,
    input  logic rst_n,

    input  logic               s0_valid,
    output logic               s0_ready,
    input  logic [DATA_W-1:0]  s0_data,
    input  logic               s0_last,

    input  logic               s1_valid,
    output logic               s1_ready,
    input  logic [DATA_W-1:0]  s1_data,
    input  logic               s1_last,

    output logic               m_valid,
    input  logic               m_ready,
    output logic [DATA_W-1:0]  m_data,
    output logic               m_last,
    output logic [0:0]         m_user
);
    logic req0;
    logic req1;
    logic gnt0;
    logic gnt1;
    logic gnt_valid;
    logic fire;

    assign req0 = s0_valid;
    assign req1 = s1_valid;
    assign fire = m_valid && m_ready;

    mint_rr_arb2 u_arb2 (
        .clk(clk),
        .rst_n(rst_n),
        .req0(req0),
        .req1(req1),
        .advance(fire),
        .gnt0(gnt0),
        .gnt1(gnt1),
        .gnt_valid(gnt_valid)
    );

    assign m_valid = gnt_valid;
    assign s0_ready = m_ready && gnt0;
    assign s1_ready = m_ready && gnt1;

    always_comb begin
        m_data = '0;
        m_user = 1'b0;

        if (gnt0) begin
            m_data = s0_data;
            m_last = s0_last;
            m_user = 1'b0;
        end else if (gnt1) begin
            m_data = s1_data;
            m_last = s1_last;
            m_user = 1'b1;
        end else begin
            m_data = '0;
            m_user = 1'b0;
        end
    end
endmodule

`default_nettype wire
