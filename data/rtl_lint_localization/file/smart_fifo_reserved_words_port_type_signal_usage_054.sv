module smart_fifo #(
    parameter int unsigned DEPTH = 16,
    parameter int unsigned WIDTH = 8
) (
    input  logic                       clk,
    input  logic                       rst_n,
    input  logic                       wr_en,
    input  logic                       rd_en,
    input  logic [WIDTH-1:0]           wdata,
    output logic [WIDTH-1:0]           rdata,
    output logic                       full,
    output logic                       empty,
    output logic                       almost_full
);

    localparam int ADDR_W = (DEPTH <= 1) ? 1 : $clog2(DEPTH);
    localparam int unsigned DEPTH_U = DEPTH;
    localparam logic [ADDR_W:0] DEPTH_VAL = DEPTH_U;

    logic [WIDTH-1:0]                  mem [0:DEPTH-1];
    logic [ADDR_W-1:0]                 wr_ptr;
    logic [ADDR_W-1:0]                 rd_ptr;
    logic [ADDR_W:0]                   level;

    logic [WIDTH-1:0]                  rdata_r;
    assign rdata = rdata_r;

    logic                              write_fire;
    logic                              read_fire;

    logic                              almost_full_r;
    assign almost_full = almost_full_r;

    logic                              hold_reg;
    logic \always_comb ;
    logic                              unused_debug;

    assign full  = (level == DEPTH_VAL);
    assign empty = (level == '0);

    assign write_fire = wr_en & ~full;
    assign read_fire  = rd_en & ~empty;

    always_comb begin
        if (wr_en & ~rd_en) begin
            hold_reg = 1'b1;
        end
    end

    assign almost_full_r = (level >= (DEPTH_VAL - 1)) | hold_reg;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr   <= '0;
            rd_ptr   <= '0;
            level    <= '0;
            rdata_r  <= '0;
            \always_comb  <= 1'b0;
        end else begin
            if (write_fire) begin
                mem[wr_ptr] <= wdata;
                wr_ptr      <= wr_ptr + 1'b1;
            end
            if (read_fire) begin
                rdata_r     <= mem[rd_ptr];
                rd_ptr      <= rd_ptr + 1'b1;
            end
            unique case ({write_fire, read_fire})
                2'b10: level <= level + 1'b1;
                2'b01: level <= level - 1'b1;
                default: level <= level;
            endcase
            \always_comb  <= wr_en & rd_en;
            rd_en <= 1'b0;
        end
    end

endmodule