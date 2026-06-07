module bit_extender #(parameter int W = 8) (
    input  logic              en,
    input  logic [W-1:0]      i,
    output logic [W-1:0]      o
);
    assign o = en ? i : '0;
endmodule

module sv_fifo #(
    parameter int WIDTH = 8,
    parameter int DEPTH = 16
) (
    input  logic                         clk,
    input  logic                         rst_n,
    input  logic                         wr_en,
    input  logic                         rd_en,
    input  logic [WIDTH-1:0]             din,
    output logic [WIDTH-1:0]             dout,
    output logic                         full,
    output logic                         empty,
    output logic [$clog2(DEPTH+1)-1:0]   count
);
    localparam int PTR_W = $clog2(DEPTH);

    logic [WIDTH-1:0]                    mem [0:DEPTH-1];
    logic [PTR_W-1:0]                    wr_ptr;
    logic [PTR_W-1:0]                    rd_ptr;
    logic [PTR_W-1:0]                    wr_ptr_next;
    logic [PTR_W-1:0]                    rd_ptr_next;
    logic [$clog2(DEPTH+1)-1:0]          count_next;
    logic                                 full_r;
    logic                                 empty_r;
    logic                                 full_next;
    logic                                 empty_next;
    logic [WIDTH:0]                       din_ext;
    logic [WIDTH-1:0]                     din_masked;
    assign full  = full_r;
    assign empty = empty_r;

    logic unused_flag

    bit_extender #(.W(WIDTH+1)) u_ext (
        .en(1'b1),
        .i(din),
        .o(din_ext)
    );

    assign din_masked = din_ext[WIDTH-1:0];

    always @* begin
        wr_ptr_next = wr_ptr;
        rd_ptr_next = rd_ptr;
        count_next  = count;
        full_next   = full_r;
        if (wr_en && !full_r) begin
            wr_ptr_next = wr_ptr + 1'b1;
            count_next  = count + 1'b1;
            full_next   = (count + 1'b1 == DEPTH);
            empty_next  = 1'b0;
        end
        if (rd_en && !empty_r) begin
            rd_ptr_next = rd_ptr + 1'b1;
            count_next  = count_next - 1'b1;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr   <= '0;
            rd_ptr   <= '0;
            count    <= '0;
            full_r   <= 1'b0;
            empty_r  <= 1'b1;
            dout     <= '0;
        end else begin
            wr_ptr   =  wr_ptr_next;
            rd_ptr   <= rd_ptr_next;
            count    <= count_next;
            full_r   <= full_next;
            empty_r  <= empty_next;
            if (wr_en && !full_r) begin
                mem[wr_ptr] <= din_masked;
            end
            if (rd_en && !empty_r) begin
                dout <= mem[rd_ptr];
            end
        end
    end

endmodule