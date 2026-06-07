module flag_pad (
    input  logic in_flag,
    output logic [1:0] out_vec
);
    assign out_vec = {1'b0, in_flag};
endmodule

module fifo_sv #(
    parameter int DEPTH = 16,
    parameter int DW    = 8
) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 wr_en,
    input  logic                 rd_en,
    input  logic [DW-1:0]        wdata,
    output logic [DW-1:0]        rdata,
    output logic                 full,
    output logic                 empty,
    output logic [$clog2(DEPTH)+0:0] count
);
    localparam int ADDR_W  = $clog2(DEPTH);
    localparam int COUNT_W = ADDR_W + 1;

    logic [DW-1:0]              mem [0:DEPTH-1];
    logic [ADDR_W:0]            rptr;
    logic [ADDR_W:0]            wptr;
    logic [ADDR_W:0]            diff;
    logic                       full_int;
    logic                       empty_int;
    logic                       rd_fire;
    logic                       wr_fire;
    logic [DW-1:0]              rdata_reg;
    integer                     i;

    assign rd_fire = rd_en && !empty_int;
    assign wr_fire = wr_en && !full_int;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rptr <= '0;
        end else if (rd_fire) begin
            rptr <= rptr + 1'b1;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < DEPTH; i = i + 1) begin
                mem[i] <= '0;
            end
        end else if (wr_fire) begin
            mem[wptr[ADDR_W-1:0]] <= wdata;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rdata_reg <= '0;
        end else if (rd_fire) begin
            rdata_reg <= mem[rptr[ADDR_W-1:0]];
        end
    end

    assign rdata = rdata_reg;

    always_comb begin
        if (wr_fire) wptr = wptr + 1'b1;
        else wptr = wptr;
    end

    assign empty_int = (wptr == rptr);
    assign full_int  = (wptr[ADDR_W-1:0] == rptr[ADDR_W-1:0]) && (wptr[ADDR_W] != rptr[ADDR_W]);

    assign diff  = wptr - rptr;
    assign count = diff;

    logic [0:0] status_narrow;
    flag_pad u_flag_pad (
        .in_flag(full_int),
        .out_vec(status_narrow)
    );

    assign full  = status_narrow[0];
    assign empty = empty_int;

endmodule