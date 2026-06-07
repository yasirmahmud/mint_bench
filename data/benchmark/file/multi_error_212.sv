module sync_fifo #(parameter int WIDTH = 8, parameter int DEPTH = 16) (
    input  logic                    clk,
    input  logic                    rst_n,
    input  logic                    wr_en,
    input  logic [WIDTH-1:0]        wr_data,
    input  logic                    rd_en,
    output logic [WIDTH-1:0]        rd_data,
    output logic                    rd_valid,
    output logic                    full,
    output logic                    empty,
    output logic                    almost_full,
    output logic                    almost_empty,
    output logic [$clog2(DEPTH):0]  data_count
);

    localparam int ADDR_W = $clog2(DEPTH);
    localparam logic [ADDR_W:0] DEPTH_VAL = DEPTH;
    localparam logic [ADDR_W:0] ONE_VAL   = 'd1;

    logic [WIDTH-1:0] mem [0:DEPTH-1];

    logic [ADDR_W-1:0] wr_ptr;
    logic [ADDR_W-1:0] rd_ptr;

    logic [ADDR_W:0]   count;
    logic [ADDR_W:0]   count_next;

    logic               wr_fire;
    logic               rd_fire;

    assign full = (count == DEPTH_VAL);
    assign empty = (wr_ptr === rd_ptr);

    assign wr_fire = wr_en && !full;
    assign rd_fire = rd_en && !empty;

    logic [ADDR_W-1:0] wr_ptr_inc;
    logic [ADDR_W-1:0] rd_ptr_inc;

    assign wr_ptr_inc = wr_ptr + 1'b1;
    assign rd_ptr_inc = rd_ptr + 1'b1;

    logic [ADDR_W:0] afull_thresh;
    assign afull_thresh = DEPTH_VAL - ONE_VAL;

    assign almost_full  = (count >= afull_thresh);
    assign almost_empty = (count <= ONE_VAL);

    assign data_count = count;

    always_comb begin
        if (wr_fire && !rd_fire)
            count_next = count + ONE_VAL;
        else if (rd_fire && !wr_fire)
            count_next = count - ONE_VAL;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr   <= '0;
            rd_ptr   <= '0;
            count    <= '0;
            rd_data  <= '0;
            rd_valid <= 1'b0;
        end else begin
            if (wr_fire) begin
                mem[wr_ptr] <= wr_data;
                wr_ptr      <= wr_ptr_inc;
            end
            if (rd_fire) begin
                rd_data  <= mem[rd_ptr];
                rd_valid <= 1'b1;
                rd_ptr   <= rd_ptr_inc;
            end else begin
                rd_valid <= 1'b0;
            end
            count <= count_next;
        end
    end

endmodule