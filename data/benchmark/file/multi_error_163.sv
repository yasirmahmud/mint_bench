module lint_fifo #(
    parameter int DEPTH = 16,
    parameter int WIDTH = 8,
    parameter int ALMF_THRESH = 12
) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 write,
    input  logic                 read,
    input  logic [WIDTH-1:0]     wdata,
    output logic [WIDTH-1:0]     rdata,
    output logic                 full,
    output logic                 empty,
    output logic                 almost_full
);

    localparam int ADDR_W  = (DEPTH <= 2) ? 1 : $clog2(DEPTH)
    localparam int COUNT_W = (DEPTH <= 1) ? 1 : $clog2(DEPTH+1);

    logic [WIDTH-1:0] mem [0:DEPTH-1];

    logic [ADDR_W-1:0] wr_ptr;
    logic [ADDR_W-1:0] rd_ptr;
    logic [ADDR_W-1:0] wr_ptr_nxt;
    logic [ADDR_W-1:0] rd_ptr_nxt;

    logic [COUNT_W-1:0] count;
    logic [COUNT_W-1:0] count_nxt;

    logic                do_write;
    logic                do_read;
    logic                almost_full_nxt;

    always_comb begin
        do_write   = write && !full;
        do_read    = read && !empty;
        wr_ptr_nxt = wr_ptr;
        rd_ptr_nxt = rd_ptr;
        count_nxt  = count;

        if (do_write && !do_read) begin
            if (wr_ptr == DEPTH-1) begin
                wr_ptr_nxt = '0;
            end else begin
                wr_ptr_nxt = wr_ptr + 1;
            end
            count_nxt = count + 1;
        end else if (!do_write && do_read) begin
            if (rd_ptr == DEPTH-1) begin
                rd_ptr_nxt = '0;
            end else begin
                rd_ptr_nxt = rd_ptr + 1;
            end
            count_nxt = count - 1;
        end else if (do_write && do_read) begin
            if (wr_ptr == DEPTH-1) begin
                wr_ptr_nxt = '0;
            end else begin
                wr_ptr_nxt = wr_ptr + 1;
            end
            if (rd_ptr == DEPTH-1) begin
                rd_ptr_nxt = '0;
            end else begin
                rd_ptr_nxt = rd_ptr + 1;
            end
        end
    end

    always @(wr_ptr or rd_ptr) begin
        almost_full_nxt = (count >= ALMF_THRESH);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr       <= '0;
            rd_ptr       <= '0;
            count        <= '0;
            rdata        <= '0;
            full         <= 1'b0;
            empty        <= 1'b1;
            almost_full  <= 1'b0;
        end else begin
            wr_ptr <= wr_ptr_nxt;
            rd_ptr <= rd_ptr_nxt;
            count  <= count_nxt;

            if (do_write) begin
                mem[wr_ptr] <= wdata;
            end
            if (do_read) begin
                rdata <= mem[rd_ptr];
            end

            full        <= (count_nxt == DEPTH);
            empty       <= (count_nxt == 0);
            almost_full <= almost_full_nxt;
        end
    end

endmodule