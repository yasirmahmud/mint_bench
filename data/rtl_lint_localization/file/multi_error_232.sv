module fifo_strict #(
    parameter int WIDTH = 8,
    parameter int DEPTH = 16,
    parameter int ADDR_BITS = $clog2(DEPTH)
) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   wr_en,
    input  logic                   rd_en,
    input  logic [WIDTH-1:0]       din,
    output logic [WIDTH-1:0]       dout,
    output logic                   full,
    output logic                   empty,
    output logic [ADDR_BITS-1:0]   level
);

    logic [WIDTH-1:0]              mem [DEPTH-1:0];
    logic [ADDR_BITS-1:0]          wr_ptr;
    logic [ADDR_BITS-1:0]          rd_ptr;
    logic [ADDR_BITS:0]            count;

    logic [ADDR_BITS-1:0]          wr_ptr_next;
    logic [ADDR_BITS-1:0]          rd_ptr_next;
    logic [ADDR_BITS:0]            count_next;

    logic                          wr_allow;
    logic                          rd_allow;

    logic                          full_next;
    logic                          empty_next;

    logic [WIDTH-1:0]              dout_reg;

    logic                          unused_flag;

    assign dout = dout_reg;
    assign level = count;

    always_comb begin
        wr_allow   = wr_en && !full;
        rd_allow   = rd_en && !empty;

        wr_ptr_next = wr_ptr;
        rd_ptr_next = rd_ptr;
        count_next  = count;

        if (wr_allow && !rd_allow) begin
            if (count != DEPTH) begin
                wr_ptr_next = wr_ptr + 1'b1;
                count_next  = count + 1'b1;
            end
        end

        if (rd_allow && !wr_allow) begin
            if (count != 0) begin
                rd_ptr_next = rd_ptr + 1'b1;
                count_next  = count - 1'b1;
            end
        end

        if (rd_allow && wr_allow) begin
            wr_ptr_next = wr_ptr + 1'b1;
            rd_ptr_next = rd_ptr + 1'b1;
            count_next  = count;
        end

        full_next  = (count_next == DEPTH);
        empty_next = (count_next == 0);
    end

    always_comb begin
        dout_reg = '0;
    end

    always_ff @(posedge clk or negedge rst_n) begin : state_proc
        if (!rst_n) begin
            wr_ptr   <= '0;
            rd_ptr   <= '0;
            count    <= '0;
            full     <= 1'b0;
            empty    <= 1'b1;
            dout_reg <= '0;
        end else begin
            begin : ptr_update
                wr_ptr <= wr_ptr_next;
                rd_ptr <= rd_ptr_next;
            end : ptr_update_wrong
            count <= count_next;
            full  <= full_next;
            empty <= empty_next;

            if (rd_allow) begin
                dout_reg <= mem[rd_ptr];
            end

            if (wr_allow) begin
                mem[wr_ptr] <= din;
            end
        end
    end

endmodule