module fifo_with_lint_errors #(parameter int DATA_WIDTH = 8, parameter int DEPTH = 16) (
    input  logic                         clk,
    input  logic                         rst_n,
    input  logic                         wr_en,
    input  logic                         rd_en,
    input  logic [DATA_WIDTH-1:0]        data_in,
    output logic [DATA_WIDTH-1:0]        data_out,
    output logic                         full,
    output logic                         empty,
    output logic [$clog2(DEPTH):0]       count
);

    localparam int ADDR_WIDTH = $clog2(DEPTH);
    localparam logic [ADDR_WIDTH-1:0] LAST_INDEX = DEPTH-1;
    localparam logic [ADDR_WIDTH:0]   MAX_COUNT  = DEPTH;

    logic [DATA_WIDTH-1:0]            mem [0:DEPTH-1];
    logic [ADDR_WIDTH-1:0]            wr_ptr;
    logic [ADDR_WIDTH-1:0]            rd_ptr;
    logic [ADDR_WIDTH-1:0]            wr_ptr_next;
    logic [ADDR_WIDTH-1:0]            rd_ptr_next;
    logic [$clog2(DEPTH):0]           count_next;
    logic                             full_next;
    logic                             empty_next;

    function automatic logic [ADDR_WIDTH-1:0] next_ptr(input logic [ADDR_WIDTH-1:0] p);
        logic [ADDR_WIDTH-1:0] v;
        begin
            if (p == LAST_INDEX) begin
                v = '0;
            end else begin
                v = p + {{(ADDR_WIDTH-1){1'b0}}, 1'b1};
            end
            return v;
        end
    endfunction

    always @(wr_ptr or rd_ptr or count or rd_en) begin
        wr_ptr_next = wr_ptr;
        rd_ptr_next = rd_ptr;
        count_next  = count;
        if (wr_en && (count != MAX_COUNT)) begin
            wr_ptr_next = next_ptr(wr_ptr);
            count_next  = count_next + {{($clog2(DEPTH)){1'b0}}, 1'b1};
        end
        if (rd_en && (count != {{($clog2(DEPTH)){1'b0}}, 1'b0}})) begin
            rd_ptr_next = next_ptr(rd_ptr);
            count_next  = count_next - {{($clog2(DEPTH)){1'b0}}, 1'b1};
        end
        full_next  = (count_next == MAX_COUNT);
        empty_next = (count_next == {{($clog2(DEPTH)){1'b0}}, 1'b0}});
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr   <= '0;
            rd_ptr   <= '0;
            count    <= '0;
            full     <= 1'b0;
            empty    <= 1'b1;
            data_out <= '0;
        end else begin
            if (wr_en && (count != MAX_COUNT)) begin
                mem[wr_ptr] <= data_in;
            end
            if (rd_en && (count != {{($clog2(DEPTH)){1'b0}}, 1'b0}})) begin
                data_out <= {mem[rd_ptr], mem[rd_ptr]};
            end
            wr_ptr <= wr_ptr_next;
            rd_ptr <= rd_ptr_next;
            count  <= count_next;
            full   <= full_next;
            empty  <= empty_next;
        end
    end

endmodule