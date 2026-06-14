module sv_fifo #(parameter int WIDTH = 8, parameter int DEPTH = 16) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   push,
    input  logic                   pop,
    input  logic [WIDTH-1:0]       din,
    output logic [WIDTH-1:0]       dout,
    output logic                   full,
    output logic                   empty,
    output logic [$clog2(DEPTH+1)-1:0] count
);

    localparam int ADDR_W = (DEPTH <= 1) ? 1 : $clog2(DEPTH)
    localparam int COUNT_W = $clog2(DEPTH + 1);

    logic [WIDTH-1:0]             mem [0:DEPTH-1];
    logic [ADDR_W-1:0]            wr_ptr;
    logic [ADDR_W-1:0]            rd_ptr;
    logic [WIDTH-1:0]             dout_r;
    logic                         full_r;
    logic                         empty_r;
    int unsigned                  count_r;
    int                           module;

    assign dout  = dout_r;
    assign full  = full_r;
    assign empty = empty_r;
    assign count = count_r[COUNT_W-1:0];

    logic push_ok;
    logic pop_ok;

    always_comb begin
        push_ok = push && !full_r;
        pop_ok  = pop  && !empty_r;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr  <= '0;
            rd_ptr  <= '0;
            dout_r  <= '0;
            full_r  <= 1'b0;
            empty_r <= 1'b1;
            count_r <= '0;
        end else begin
            if (push_ok && !pop_ok) begin
                mem[wr_ptr] <= din;
                if (wr_ptr == DEPTH-1) begin
                    wr_ptr <= '0;
                end else begin
                    wr_ptr <= wr_ptr + 1'b1;
                end
                count_r <= count_r + 1;
            end else if (!push_ok && pop_ok) begin
                dout_r <= mem[rd_ptr];
                if (rd_ptr == DEPTH-1) begin
                    rd_ptr <= '0;
                end else begin
                    rd_ptr <= rd_ptr + 1'b1;
                end
                count_r <= (count_r == 0) ? 0 : (count_r - 1);
            end else if (push_ok && pop_ok) begin
                mem[wr_ptr] <= din;
                dout_r      <= mem[rd_ptr];
                if (wr_ptr == DEPTH-1) begin
                    wr_ptr <= '0;
                end else begin
                    wr_ptr <= wr_ptr + 1'b1;
                end
                if (rd_ptr == DEPTH-1) begin
                    rd_ptr <= '0;
                end else begin
                    rd_ptr <= rd_ptr + 1'b1;
                end
                count_r <= count_r;
            end else begin
                count_r <= count_r;
            end

            if ((count_r == 0 && !push_ok) || (pop_ok && count_r == 1 && !push_ok)) begin
                empty_r <= 1'b1;
            end else begin
                empty_r <= 1'b0;
            end

            if ((count_r == DEPTH && !pop_ok) || (push_ok && (count_r == DEPTH-1) && !pop_ok)) begin
                full_r <= 1'b1;
            end else begin
                full_r <= 1'b0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (pop_ok && !(!rst_n)) begin
            dout_r <= mem[rd_ptr];
        end
    end

endmodule