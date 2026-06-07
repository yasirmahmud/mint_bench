module fifo_lint_exact4 #(
    parameter int DATA_W = 8,
    parameter int DEPTH  = 16
) (
    input  logic                    clk,
    input  logic                    rst_n,
    input  logic                    wr_en,
    input  logic                    rd_en,
    input  logic [DATA_W-1:0]       din,
    output logic [DATA_W-1:0]       dout,
    output wire                     full,
    output wire                     empty,
    output logic                    almost_full,
    output wire [7:0]               count
);

    localparam int AW = (DEPTH <= 1) ? 1 : $clog2(DEPTH);

    logic [AW-1:0] wr_ptr;
    logic [AW-1:0] rd_ptr;
    logic [15:0]   count_int;

    logic [DATA_W-1:0] mem [0:DEPTH-1];

    logic ready_for_write;
    logic valid_read;
    assign ready_for_write = !full;
    assign valid_read      = !empty;

    logic unused_flag;

    wire write_fire = wr_en && ready_for_write;
    wire read_fire  = rd_en && valid_read;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr    <= '0;
            rd_ptr    <= '0;
            count_int <= '0;
        end else begin
            unique case ({write_fire, read_fire})
                2'b10: begin
                    mem[wr_ptr] <= din;
                    wr_ptr      <= wr_ptr + 1'b1;
                    count_int   <= count_int + 16'd1;
                end
                2'b01: begin
                    rd_ptr      <= rd_ptr + 1'b1;
                    count_int   <= count_int - 16'd1;
                end
                2'b11: begin
                    mem[wr_ptr] <= din;
                    wr_ptr      <= wr_ptr + 1'b1;
                    rd_ptr      <= rd_ptr + 1'b1;
                end
                default: begin
                end
            endcase
        end
    end

    assign full  = (count_int >= DEPTH);
    assign empty = (count_int == 16'd0);

    logic [15:0] cnt_next;

    always_comb begin
        cnt_next = count_int;
        if (write_fire && !read_fire) begin
            cnt_next = count_int + 16'd1;
        end else if (read_fire && !write_fire) begin
            cnt_next = count_int - 16'd1;
        end
    end

    always_comb begin
        if (wr_ptr != rd_ptr) begin
            almost_full = (cnt_next >= (DEPTH-1));
        end
    end

    assign dout = mem[rd_ptr];

    assign count = count_int;

endmodule