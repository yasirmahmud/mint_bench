module cmpN #(parameter int N = 1) (
    input  logic [N-1:0] a,
    input  logic [N-1:0] b,
    output logic         eq
);
    always_comb begin
        eq = (a == b);
    end
endmodule

module fifo_sv #(
    parameter int WIDTH = 8,
    parameter int DEPTH = 16
) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   write_en,
    input  logic                   read_en,
    input  logic [WIDTH-1:0]       data_in,
    output logic [WIDTH-1:0]       data_out,
    output logic                   full,
    output logic                   empty,
    output logic                   almost_full,
    output logic                   almost_empty,
    output logic                   can_write,
    output logic                   can_read,
    output logic [$clog2(DEPTH):0] count_out
);
    localparam int PTR_W = $clog2(DEPTH);

    logic [WIDTH-1:0]             mem [0:DEPTH-1];
    logic [PTR_W-1:0]             wr_ptr;
    logic [PTR_W-1:0]             rd_ptr;
    logic [PTR_W:0]               count;
    logic [WIDTH-1:0]             data_out_r;
    logic                         empty_by_cmp;
    logic                         will_write;
    logic                         will_read;

    function automatic logic [PTR_W-1:0] inc_ptr(input logic [PTR_W-1:0] p);
        if (p == DEPTH-1) begin
            inc_ptr = '0;
        end else begin
            inc_ptr = p + 1'b1;
        end
    endfunction

    assign will_write = write_en && (count < DEPTH);
    assign will_read  = read_en  && (count > 0);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr      <= '0;
            rd_ptr      <= '0;
            count       <= '0;
            data_out_r  <= '0;
        end else begin
            if (will_write && will_read) begin
                mem[wr_ptr] <= data_in;
                data_out_r  <= mem[rd_ptr];
                wr_ptr      <= inc_ptr(wr_ptr);
                rd_ptr      <= inc_ptr(rd_ptr);
            end else if (will_write) begin
                mem[wr_ptr] <= data_in;
                wr_ptr      <= inc_ptr(wr_ptr);
                count       <= count + 1'b1;
            end else if (will_read) begin
                data_out_r  <= mem[rd_ptr];
                rd_ptr      <= inc_ptr(rd_ptr);
                count       <= count - 1'b1;
            end else begin
                count       <= count;
            end
        end
    end

    cmpN #(.N(PTR_W)) u_cmp_zero (
        .a(count),
        .b({PTR_W{1'b0}}),
        .eq(empty_by_cmp)
    );

    assign data_out     = data_out_r;
    assign empty        = empty_by_cmp;
    assign full         = (count == DEPTH);
    assign almost_full  = (count >= (DEPTH-1));
    assign almost_empty = (count <= 1);
    assign can_read     = (count > 0);
    assign count_out    = count;

    always @(wr_ptr or rd_ptr) begin
        if ((count < DEPTH) || (wr_ptr == rd_ptr)) begin
            can_write = 1'b1;
        end else begin
            can_write = 1'b0;
        end
    end

endmodule