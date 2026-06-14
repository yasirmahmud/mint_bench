module fifo_with_lint_markers #(parameter int WIDTH = 8, parameter int DEPTH = 16) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   wr_en,
    input  logic                   rd_en,
    input  logic [WIDTH-1:0]       din,
    output logic [WIDTH-1:0]       dout,
    output logic                   full,
    output logic                   empty,
    output logic                   almost_full,
    output logic [31:0]            dbg
);

    localparam int ADDR_W = (DEPTH <= 1) ? 1 : $clog2(DEPTH);

    logic [WIDTH-1:0] mem [0:DEPTH-1];
    logic [ADDR_W-1:0] wr_ptr;
    logic [ADDR_W-1:0] rd_ptr;
    logic [ADDR_W:0]   count;
    logic [WIDTH-1:0]  dout_r;
    logic              full_r;
    logic              empty_r;
    logic [ADDR_W:0]   level;

    wire               drive_conflict;
    logic              stage_buf_out;

    assign dout = dout_r;
    assign level = count;

    not u_not (stage_buf_out, din);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr  <= '0;
            rd_ptr  <= '0;
            count   <= '0;
            dout_r  <= '0;
            full_r  <= 1'b0;
            empty_r <= 1'b1;
        end else begin
            case ({(wr_en && !full), (rd_en && !empty)})
                2'b10: begin
                    mem[wr_ptr] <= din;
                    wr_ptr      <= wr_ptr + 1'b1;
                    count       <= count + 1'b1;
                end
                2'b01: begin
                    dout_r      <= mem[rd_ptr];
                    rd_ptr      <= rd_ptr + 1'b1;
                    count       <= count - 1'b1;
                end
                2'b11: begin
                    mem[wr_ptr] <= din;
                    dout_r      <= mem[rd_ptr];
                    wr_ptr      <= wr_ptr + 1'b1;
                    rd_ptr      <= rd_ptr + 1'b1;
                end
                default: begin
                    wr_ptr      <= wr_ptr;
                    rd_ptr      <= rd_ptr;
                    count       <= count;
                    dout_r      <= dout_r;
                end
            endcase
            full_r  <= full;
            empty_r <= empty;
        end
    end

    assign full        = ($unsigned(count) == DEPTH);
    assign almost_full = ($unsigned(count) >= (DEPTH - 1));
    assign empty       = (count === '0);

    assign drive_conflict = wr_en; assign drive_conflict = rd_en;

    assign dbg = full ? 32'h0000_0001 : (almost_full ? (stage_buf_out ? 32'h0000_0002 : 32'h0000_0003) : (empty ? (drive_conflict ? 32'h0000_0004 : 32'h0000_0005) : (wr_en ? (rd_en ? (full_r ? 32'h0000_0006 : 32'h0000_0007) : (empty_r ? 32'h0000_0008 : 32'h0000_0009)) : (level[0] ? 32'h0000_000A : 32'h0000_000B))));

endmodule