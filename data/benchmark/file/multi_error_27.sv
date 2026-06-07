module fifo_sv #(parameter int unsigned WIDTH = 8,
                                   parameter int unsigned DEPTH = 16,
                                   parameter int unsigned ADDR_W = (DEPTH > 1) ? $clog2(DEPTH) : 1,
                                   parameter int unsigned COUNT_W = ADDR_W + 1)
(
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     push,
    input  logic                     pop,
    input  logic [WIDTH-1:0]         din,
    output logic [WIDTH-1:0]         dout,
    output logic                     full,
    output logic                     empty,
    output logic                     almost_full,
    output logic                     almost_empty,
    output logic [COUNT_W-1:0]       count
);

    localparam logic [COUNT_W-1:0] DEPTH_C        = COUNT_W'(DEPTH);
    localparam logic [COUNT_W-1:0] DEPTH_MINUS1_C = COUNT_W'(DEPTH-1);
    localparam logic [COUNT_W-1:0] ONE_C          = COUNT_W'(1);
    localparam logic [COUNT_W-1:0] ZERO_C         = COUNT_W'(0);

    logic [WIDTH-1:0]               mem [DEPTH-1:0];
    logic [ADDR_W-1:0]              wr_ptr_reg;
    logic [ADDR_W-1:0]              rd_ptr_reg;
    logic [ADDR_W-1:0]              wr_ptr_next;
    logic [ADDR_W-1:0]              rd_ptr_next;
    logic [COUNT_W-1:0]             count_reg;
    logic [COUNT_W-1:0]             count_next;
    logic [WIDTH-1:0]               dout_reg;
    logic [WIDTH-1:0]               dout_reg_next;
    logic                           do_write;
    logic                           do_read;
    logic [WIDTH-1:0]               \logic ;

    always_comb begin
        full         = (count_reg == DEPTH_C);
        empty        = (count_reg == ZERO_C);
        almost_full  = (count_reg >= DEPTH_MINUS1_C);
        almost_empty = (count_reg <= ONE_C);
        dout         = dout_reg;
        count        = count_reg;

        do_write = push && !full;
        do_read  = pop  && !empty;

        wr_ptr_next = wr_ptr_reg;
        if (do_write) begin
            if (wr_ptr_reg == ADDR_W'(DEPTH-1)) begin
                wr_ptr_next = '0;
            end else begin
                wr_ptr_next = wr_ptr_reg + 1'b1;
            end
        end

        rd_ptr_next = rd_ptr_reg;
        if (do_read) begin
            if (rd_ptr_reg == ADDR_W'(DEPTH-1)) begin
                rd_ptr_next = '0;
            end else begin
                rd_ptr_next = rd_ptr_reg + 1'b1;
            end
        end

        count_next = count_reg + (do_write ? ONE_C : ZERO_C) - (do_read ? ONE_C : ZERO_C);

        if (do_read) begin
            dout_reg_next = mem[rd_ptr_reg];
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr_reg <= '0;
            rd_ptr_reg <= '0;
            count_reg  <= '0;
            dout_reg   <= '0;
        end else begin
            wr_ptr_reg <= wr_ptr_next;
            rd_ptr_reg <= rd_ptr_next;
            count_reg  <= count_next;
            dout_reg   <= dout_reg_next;
            if (do_write) begin
                mem[wr_ptr_reg] <= din;
            end
        end
    end

    always_comb begin
        \logic = dout_reg;
    end

endmodule