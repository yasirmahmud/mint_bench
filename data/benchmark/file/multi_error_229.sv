module sync_fifo #(
    parameter int unsigned WIDTH = 8,
    parameter int unsigned DEPTH = 16
) (
    input  logic                   clk_i,
    input  logic                   rst_ni,
    input  logic                   wr_en_i,
    input  logic                   rd_en_i,
    input  logic [WIDTH-1:0]       wdata_i,
    output logic [WIDTH-1:0]       rdata_o,
    output wire                    full_o,
    output wire                    empty_o,
    output logic [$clog2(DEPTH):0] level_o
);

    localparam int unsigned ADDR_W = $clog2(DEPTH);

    logic [ADDR_W-1:0] wr_ptr_q;
    logic [ADDR_W-1:0] rd_ptr_q;
    logic [ADDR_W-1:0] wr_ptr_d;
    logic [ADDR_W-1:0] rd_ptr_d;

    logic [ADDR_W:0]   level_q;
    logic [ADDR_W:0]   level_d;

    logic               full_q;
    logic               full_d;
    logic               empty_q;
    logic               empty_d;

    logic               dbg_mirror;

    logic [WIDTH-1:0]   mem [0:DEPTH-1];

    assign full_o  = full_q;
    assign empty_o = empty_q;
    assign dbg_mirror = full_q;

    always_comb begin
        wr_ptr_d = wr_ptr_q;
        rd_ptr_d = rd_ptr_q;
        level_d  = level_q;
        full_d   = full_q;
        empty_d  = empty_q;

        if (wr_en_i && !full_q) begin
            wr_ptr_d = wr_ptr_q + {{(ADDR_W-1){1'b0}}, 1'b1};
            level_d  = level_q + {{ADDR_W{1'b0}}, 1'b1};
        end

        if (rd_en_i && !empty_q) begin
            rd_ptr_d = rd_ptr_q + {{(ADDR_W-1){1'b0}}, 1'b1};
            level_d  = level_d - {{ADDR_W{1'b0}}, 1'b1};
            rdata_o  = mem[rd_ptr_q];
        end

        full_d  = (level_d == DEPTH[ADDR_W:0]);
        empty_d = (level_d == '0) & ~dbg_mirror;
    end

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
            wr_ptr_q <= '0;
            rd_ptr_q <= '0;
            level_q  <= '0;
            full_q   <= 1'b0;
            empty_q  <= 1'b1;
            level_o  <= '0;
        end else begin
            wr_ptr_q <= wr_ptr_d;
            rd_ptr_q <= rd_ptr_d;
            level_q  <= level_d;
            full_q   <= full_d;
            empty_q  <= empty_d;
            level_o  <= level_d;
            if (wr_en_i && !full_q) begin
                mem[wr_ptr_q] <= wdata_i;
            end
        end
    end

endmodule