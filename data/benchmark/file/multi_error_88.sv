module fifo_nested #(parameter int WIDTH = 8, parameter int DEPTH = 16, parameter int ADDR_W = $clog2(DEPTH), parameter int COUNT_W = $clog2(DEPTH+1)) (
    input  logic                   clk,
    input  logic                   rst,
    input  logic                   push,
    input  logic                   pop,
    input  logic [WIDTH-1:0]       din,
    output logic [WIDTH-1:0]       dout,
    output logic                   full,
    output logic                   empty,
    output logic [COUNT_W-1:0]     count
);

logic [WIDTH-1:0] mem [0:DEPTH-1];

logic [ADDR_W-1:0] wr_ptr;
logic [ADDR_W-1:0] rd_ptr;
logic [ADDR_W-1:0] wr_ptr_next;
logic [ADDR_W-1:0] rd_ptr_next;

logic [ADDR_W-1:0] wr_ptr_plus;
logic [ADDR_W-1:0] rd_ptr_plus;

logic [COUNT_W-1:0] count_next;

logic write_allow;
logic read_allow;

function automatic logic [ADDR_W-1:0] inc_ptr(input logic [ADDR_W-1:0] ptr);
    logic [ADDR_W-1:0] res;
    begin
        if (ptr == ADDR_W'(DEPTH-1)) begin
            res = '0;
        end else begin
            res = ptr + ADDR_W'(1);
        end
        return res;
    end
endfunction

assign empty = (count == COUNT_W'(0));
assign full  = (count == COUNT_W'(DEPTH));

assign read_allow = pop && !empty;

assign write_allow = push ? (full ? (pop ? 1'b0 : 1'b0) : (pop ? (empty ? 1'b1 : 1'b1) : (push ? 1'b1 : 1'b1))) : (pop ? (full ? (push ? 1'b0 : 1'b0) : (empty ? 1'b0 : 1'b0)) : (push ? (empty ? 1'b0 : 1'b0) : 1'b0));

always_comb begin
    wr_ptr_plus = inc_ptr(wr_ptr);
    rd_ptr_plus = inc_ptr(rd_ptr);

    wr_ptr_next = wr_ptr;
    count_next  = count;

    if (write_allow) begin
        wr_ptr_next = wr_ptr_plus;
    end

    if (read_allow) rd_ptr_next = rd_ptr_plus;

    if (write_allow && !read_allow) begin
        if (count != COUNT_W'(DEPTH)) begin
            count_next = count + COUNT_W'(1);
        end else begin
            count_next = count;
        end
    end else if (!write_allow && read_allow) begin
        if (count != COUNT_W'(0)) begin
            count_next = count - COUNT_W'(1);
        end else begin
            count_next = count;
        end
    end else begin
        count_next = count;
    end
end

assign dout = mem[rd_ptr];

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        wr_ptr <= '0;
        rd_ptr <= '0;
        count  <= '0;
    end else begin
        wr_ptr <= wr_ptr_next;
        rd_ptr <= rd_ptr_next;
        count  <= count_next;
        if (write_allow) begin
            mem[wr_ptr] <= din;
        end
    end
end

endmodule