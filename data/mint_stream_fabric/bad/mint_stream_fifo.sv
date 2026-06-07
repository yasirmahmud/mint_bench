`default_nettype none

module mint_stream_fifo #(
    parameter int unsigned DATA_W = 32,
    parameter int unsigned USER_W = 1,
    parameter int unsigned DEPTH  = 8,
    parameter int unsigned LEVEL_W = $clog2(DEPTH + 1)
) (
    input  logic               clk,
    input  logic               rst_n,

    input  logic               s_valid,
    output logic               s_ready,
    input  logic [DATA_W-1:0]  s_data,
    input  logic               s_last,
    input  logic [USER_W-1:0]  s_user,

    output logic               m_valid,
    input  logic               m_ready,
    output logic [DATA_W-1:0]  m_data,
    output logic               m_last,
    output logic [USER_W-1:0]  m_user,

    output logic [LEVEL_W-1:0] level
);
    localparam int unsigned ADDR_W = $clog2(DEPTH);
    localparam int unsigned PAY_W = DATA_W + 1 + USER_W;

    logic [PAY_W-1:0] mem [0:DEPTH-1];

    logic [ADDR_W-1:0] wr_ptr;
    logic [ADDR_W-1:0] rd_ptr;
    logic [LEVEL_W-1:0] count;

    logic full;
    logic empty;

    logic push;
    logic pop;

    logic [PAY_W-1:0] payload_wr;
    logic [PAY_W-1:0] payload_rd;

    localparam int unsigned PTR_MAX_INT = (DEPTH - 1);
    localparam logic [ADDR_W-1:0] PTR_MAX = PTR_MAX_INT[ADDR_W-1:0];
    localparam logic [LEVEL_W-1:0] DEPTH_COUNT = DEPTH[LEVEL_W-1:0];

    function automatic logic [ADDR_W-1:0] ptr_inc(input logic [ADDR_W-1:0] ptr);
        if (ptr == PTR_MAX) begin
            ptr_inc = '0;
        end else begin
            ptr_inc = ptr + {{(ADDR_W-1){1'b0}}, 1'b1};
        end
    endfunction

    assign full = (count == DEPTH_COUNT);
    assign empty = (count == '0);

    assign s_ready = !full;
    assign m_valid = !empty;
    assign level = count;

    assign push = s_valid && s_ready;
    assign pop = m_valid && m_ready;

    assign payload_wr = {s_last, s_user, s_data};

    always_comb begin
        payload_rd = '0;
        if (!empty) begin
            payload_rd = mem[rd_ptr];
        end
    end

    assign {m_last, m_user, m_data} = payload_rd;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            wr_ptr <= '0;
            rd_ptr <= '0;
            count <= '0;
        end else begin
            if (push && !pop) begin
                mem[wr_ptr] <= payload_wr;
                wr_ptr <= ptr_inc(wr_ptr);
                count <= count + {{(LEVEL_W-1){1'b0}}, 1'b1};
            end else if (!push && pop) begin
                rd_ptr <= ptr_inc(rd_ptr);
                count <= count - {{(LEVEL_W-1){1'b0}}, 1'b1};
            end else if (push && pop) begin
                mem[wr_ptr] <= payload_wr;
                wr_ptr <= ptr_inc(wr_ptr);
                rd_ptr <= ptr_inc(rd_ptr);
            end
        end
    end
endmodule

`default_nettype wire
