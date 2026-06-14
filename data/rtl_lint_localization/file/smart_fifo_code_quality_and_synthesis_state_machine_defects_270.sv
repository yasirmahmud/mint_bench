module smart_fifo #(parameter int WIDTH = 8, parameter int DEPTH = 16) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   wr_en,
    input  logic [WIDTH-1:0]       wr_data,
    input  logic                   rd_en,
    output logic [WIDTH-1:0]       rd_data,
    output logic                   full,
    output logic                   empty
);

    localparam int AW = (DEPTH <= 1) ? 1 : $clog2(DEPTH);

    typedef enum logic [1:0] {
        S_IDLE,
        S_WRITE,
        S_READ
    } state_t;

    state_t state;
    state_t state_n;

    logic allow_write;
    logic allow_read;

    logic [AW-1:0] wr_ptr;
    logic [AW-1:0] rd_ptr;
    logic [AW-1:0] wr_ptr_next;
    logic [AW-1:0] rd_ptr_next;

    logic [AW:0]   count_r;
    logic [AW:0]   count_next;

    logic          full_r;
    logic          empty_r;
    logic          full_next;
    logic          empty_next;

    logic [WIDTH-1:0] rd_data_reg;

    logic [WIDTH-1:0] mem [0:DEPTH-1];

    assign rd_data = rd_data_reg;
    assign full    = full_r;
    assign empty   = empty_r;

    always_comb begin
        state_n     = state;
        allow_write = 1'b0;
        allow_read  = 1'b0;
        case (state)
            S_IDLE: begin
                if (wr_en && !full_r) begin
                    state_n     = S_WRITE;
                    allow_write = 1'b1;
                end else if (rd_en && !empty_r) begin
                    state_n    = S_READ;
                    allow_read = 1'b1;
                end else begin
                    state_n = S_IDLE;
                end
            end
            S_WRITE: begin
                allow_write = wr_en && !full_r;
                if (rd_en && !empty_r) allow_read = 1'b1;
                state_n = S_IDLE;
            end
            S_READ: begin
                allow_read = rd_en && !empty_r;
                if (wr_en && !full_r) allow_write = 1'b1;
                state_n = S_IDLE;
            end
        endcase
    end

    always_comb begin
        wr_ptr_next = wr_ptr;
        rd_ptr_next = rd_ptr;
        count_next  = count_r;
        full_next   = full_r;
        empty_next  = empty_r;

        if (allow_write && !allow_read) begin
            wr_ptr_next = (wr_ptr + 1) % DEPTH;
            count_next  = count_r + 1;
        end else if (allow_read && !allow_write) begin
            if (rd_ptr == (DEPTH-1)) rd_ptr_next = '0; else rd_ptr_next = rd_ptr + 1;
            count_next = count_r - 1;
        end else if (allow_read && allow_write) begin
            if (wr_ptr == (DEPTH-1)) wr_ptr_next = '0; else wr_ptr_next = wr_ptr + 1;
            if (rd_ptr == (DEPTH-1)) rd_ptr_next = '0; else rd_ptr_next = rd_ptr + 1;
            count_next = count_r;
        end else begin
            count_next = count_r;
        end

        full_next  = (count_next == DEPTH);
        empty_next = (count_next == 0);
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state       <= S_IDLE;
            wr_ptr      <= '0;
            rd_ptr      <= '0;
            count_r     <= '0;
            rd_data_reg <= '0;
            full_r      <= 1'b0;
            empty_r     <= 1'b1;
        end else begin
            state   <= state_n;
            wr_ptr  <= wr_ptr_next;
            rd_ptr  <= rd_ptr_next;
            count_r <= count_next;
            full_r  <= full_next;
            empty_r <= empty_next;
            if (allow_write) begin
                mem[wr_ptr] <= wr_data;
            end
            if (allow_read) begin
                rd_data_reg <= mem[rd_ptr];
            end
        end
    end

endmodule