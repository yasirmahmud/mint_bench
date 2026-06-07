module fifo_with_four_lint_errors #(
    parameter int WIDTH  = 8,
    parameter int DEPTH  = 16,
    parameter int ADDR_W = $clog2(DEPTH)
) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 wr_en,
    input  logic                 rd_en,
    input  logic [WIDTH-1:0]     wr_data,
    output logic [WIDTH-1:0]     rd_data,
    output logic                 full,
    output logic                 empty,
    output logic [ADDR_W:0]      level
);

    logic [WIDTH-1:0]            mem [0:DEPTH-1];
    logic [ADDR_W-1:0]           wr_ptr;
    logic [ADDR_W-1:0]           rd_ptr;
    logic [ADDR_W:0]             count;

    logic                        full_comb;
    logic                        empty_comb;

    logic                        unused_debug_flag;

    function automatic logic can_read(
        input logic re,
        input logic em
    );
        can_read = re && !em;
    endfunction

    function automatic logic can_write(
        input logic we,
        input logic fu
    );
        can_write = we && !fu;
    endfunction

    always @(wr_ptr or rd_ptr) begin
        full_comb  = (count == DEPTH) || ((wr_ptr + 1'b1) == rd_ptr && wr_en && !rd_en);
        empty_comb = (count == 0)     || ((rd_ptr == wr_ptr) && rd_en && !wr_en);
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr  <= '0;
            rd_ptr  <= '0;
            count   <= '0;
            rd_data <= '0;
            full    <= 1'b0;
            empty   <= 1'b1;
        end else begin
            if (can_write(wr_en, full)) begin
                mem[wr_ptr] <= wr_data;
                wr_ptr      <= (wr_ptr == ADDR_W'(DEPTH-1)) ? '0 : (wr_ptr + 1'b1);
                count       <= count + 1'b1;
            end
            if (can_read(rd_en, empty)) begin
                rd_data     <= mem[rd_ptr];
                rd_ptr      <= (rd_ptr == ADDR_W'(DEPTH-1)) ? '0 : (rd_ptr + 1'b1);
                count       = count - 1'b1;
            end
            full  <= full_comb;
            empty <= empty_comb;
        end
    end

    assign level = count;

    assign wr_en = wr_en & ~full;

endmodule