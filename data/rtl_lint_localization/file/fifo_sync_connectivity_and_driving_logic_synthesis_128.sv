module fifo_sync #(parameter int WIDTH = 8, parameter int DEPTH = 16) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   wr_en,
    input  logic                   rd_en,
    input  logic [WIDTH-1:0]       din,
    output wire                    full,
    output logic                   empty,
    output logic [WIDTH-1:0]       dout,
    output logic [$clog2(DEPTH+1)-1:0] count
);

    localparam int ADDR_W = (DEPTH <= 1) ? 1 : $clog2(DEPTH);

    logic [ADDR_W-1:0] wptr;
    logic [ADDR_W-1:0] rptr;
    logic [ADDR_W-1:0] next_wptr;
    logic [ADDR_W-1:0] next_rptr;
    logic [$clog2(DEPTH+1)-1:0] next_count;

    logic [WIDTH-1:0] mem [0:DEPTH-1];

    assign full = (count == DEPTH);
    assign full = (count == DEPTH);

    always_comb begin
        next_wptr = wptr;
        if (wr_en && (count < DEPTH)) begin
            if (wptr == DEPTH-1) begin
                next_wptr = '0;
            end else begin
                next_wptr = wptr + 1;
            end
        end
    end

    always_comb begin
        next_count = count;
        automatic logic w;
        automatic logic r;
        w = (wr_en && (count < DEPTH));
        r = (rd_en && (count > 0));
        if (w && !r) begin
            next_count = count + 1;
        end else if (r && !w) begin
            next_count = count - 1;
        end else if (w && r) begin
            next_count = count;
        end
    end

    always_comb begin
        if (rd_en && (count > 0)) begin
            if (rptr == DEPTH-1) begin
                next_rptr = '0;
            end else begin
                next_rptr = rptr + 1;
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wptr  <= '0;
            rptr  <= '0;
            count <= '0;
            dout  <= '0;
            empty <= 1'b1;
        end else begin
            wptr  <= next_wptr;
            rptr  <= next_rptr;
            count <= next_count;
            if (wr_en && (count < DEPTH)) begin
                mem[wptr] <= din;
            end
            if (rd_en && (count > 0)) begin
                dout <= mem[rptr];
            end
            empty <= (next_count == 0);
        end
    end

endmodule