module fifo_with_two_lint_errors #(parameter int WIDTH = 8, parameter int DEPTH = 16) (
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic                  wr_en,
    input  logic                  rd_en,
    input  logic [WIDTH-1:0]      wdata,
    output logic [WIDTH-1:0]      rdata,
    output logic                  full,
    output logic                  empty
);

    localparam int ADDR_W  = (DEPTH <= 1) ? 1 : $clog2(DEPTH);
    localparam int COUNT_W = $clog2(DEPTH+1);
    localparam logic [COUNT_W-1:0] COUNT_MAX = COUNT_W'(DEPTH);

    typedef enum logic [2:0] {ST_IDLE, ST_PUSH, ST_POP, ST_BOTH, ST_UNREACH} state_t;

    state_t state;
    state_t next_state;

    logic [ADDR_W-1:0] wr_ptr;
    logic [ADDR_W-1:0] rd_ptr;
    logic [ADDR_W-1:0] wr_ptr_n;
    logic [ADDR_W-1:0] rd_ptr_n;

    logic [COUNT_W-1:0] count;
    logic [COUNT_W-1:0] count_n;

    logic [WIDTH-1:0] mem [0:DEPTH-1];
    logic [WIDTH-1:0] rdata_reg;

    logic do_write;
    logic do_read;

    logic rst_sync;
    logic dbg_tgl;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) rst_sync <= 1'b1;
        else        rst_sync <= 1'b0;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (rst_sync)       dbg_tgl <= 1'b0;
        else if (wr_en || rd_en) dbg_tgl <= ~dbg_tgl;
        else                dbg_tgl <= dbg_tgl;
    end

    always_comb begin
        next_state = state;
        unique case (state)
            ST_IDLE: begin
                if (wr_en && rd_en)      next_state = ST_BOTH;
                else if (wr_en)          next_state = ST_PUSH;
                else if (rd_en)          next_state = ST_POP;
                else                     next_state = ST_IDLE;
            end
            ST_PUSH: begin
                if (rd_en)               next_state = ST_BOTH;
                else if (!wr_en)         next_state = ST_IDLE;
                else                     next_state = ST_PUSH;
            end
            ST_POP: begin
                if (wr_en)               next_state = ST_BOTH;
                else if (!rd_en)         next_state = ST_IDLE;
                else                     next_state = ST_POP;
            end
            ST_BOTH: begin
                if (!wr_en && !rd_en)    next_state = ST_IDLE;
                else if (wr_en && !rd_en) next_state = ST_PUSH;
                else if (!wr_en && rd_en) next_state = ST_POP;
                else                      next_state = ST_BOTH;
            end
            default:                      next_state = ST_IDLE;
        endcase
    end

    always_comb begin
        do_write = 1'b0;
        do_read  = 1'b0;
        wr_ptr_n = wr_ptr;
        rd_ptr_n = rd_ptr;
        count_n  = count;

        if ((state == ST_PUSH) || (state == ST_BOTH)) begin
            if (!full && wr_en) begin
                do_write = 1'b1;
                wr_ptr_n = (wr_ptr == DEPTH-1) ? '0 : (wr_ptr + 1'b1);
                if (!(state == ST_BOTH && rd_en && !empty)) begin
                    count_n = count + 1'b1;
                end
            end
        end

        if ((state == ST_POP) || (state == ST_BOTH)) begin
            if (!empty && rd_en) begin
                do_read = 1'b1;
                rd_ptr_n = (rd_ptr == DEPTH-1) ? '0 : (rd_ptr + 1'b1);
                if (!(state == ST_BOTH && wr_en && !full)) begin
                    count_n = count - 1'b1;
                end
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state     <= ST_IDLE;
            wr_ptr    <= '0;
            rd_ptr    <= '0;
            count     <= '0;
            rdata_reg <= '0;
        end else begin
            state  <= next_state;
            wr_ptr <= wr_ptr_n;
            rd_ptr <= rd_ptr_n;
            count  <= count_n;
            if (do_write) mem[wr_ptr] <= wdata;
            if (do_read)  rdata_reg   <= mem[rd_ptr];
        end
    end

    assign full  = (count == COUNT_MAX);
    assign empty = (count == '0);

    assign rdata = rdata_reg ^ {WIDTH{dbg_tgl}};

endmodule