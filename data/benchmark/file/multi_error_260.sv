module fifo_sv #(
    parameter int WIDTH = 16,
    parameter int DEPTH = 16,
    parameter int ADDR_W = $clog2(DEPTH)
) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     wr_en,
    input  logic                     rd_en,
    input  logic [WIDTH-1:0]         din,
    output logic [7:0]               dout,
    output logic                     full,
    output logic                     empty,
    output logic                     almost_full,
    output logic                     almost_empty
);

localparam int ALMOST_FULL_GAP  = 2;
localparam int ALMOST_EMPTY_GAP = 2;
localparam int WATERMARK = DEPTH/2

logic [WIDTH-1:0] mem [0:DEPTH-1];

logic [ADDR_W-1:0] wptr;
logic [ADDR_W-1:0] rptr;

logic [ADDR_W:0]   count;

logic [7:0]        dout_q;

localparam logic [ADDR_W:0] DEPTH_VAL   = DEPTH;
localparam logic [ADDR_W:0] AF_GAP_VAL  = ALMOST_FULL_GAP;
localparam logic [ADDR_W:0] AE_GAP_VAL  = ALMOST_EMPTY_GAP;
localparam logic [ADDR_W-1:0] DEPTH_M1  = DEPTH - 1;

typedef enum logic [1:0] {
    ST_IDLE,
    ST_WRITE,
    ST_READ,
    ST_ERR
} state_e;

state_e state;
state_e next_state;

logic wr_do;
logic rd_do;

logic incr;
logic decr;

logic logic;

assign incr = wr_do & ~rd_do;
assign decr = rd_do & ~wr_do;

assign full  = (count == DEPTH_VAL);
assign empty = (count == { (ADDR_W+1){1'b0} });

assign almost_full  = (count >= (DEPTH_VAL - AF_GAP_VAL));
assign almost_empty = (count <= AE_GAP_VAL);

assign dout = dout_q;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state  <= ST_IDLE;
        wptr   <= {ADDR_W{1'b0}};
        rptr   <= {ADDR_W{1'b0}};
        count  <= {(ADDR_W+1){1'b0}};
        dout_q <= 8'h00;
    end else begin
        state <= next_state;
        if (wr_do) begin
            mem[wptr] <= din;
            if (wptr == DEPTH_M1) begin
                wptr <= {ADDR_W{1'b0}};
            end else begin
                wptr <= wptr + 1'b1;
            end
        end
        if (rd_do) begin
            dout_q <= mem[rptr];
            if (rptr == DEPTH_M1) begin
                rptr <= {ADDR_W{1'b0}};
            end else begin
                rptr <= rptr + 1'b1;
            end
        end
        if (incr && !decr) begin
            count <= count + 1'd1;
        end else if (decr && !incr) begin
            count <= count - 1'd1;
        end else begin
            count <= count;
        end
        logic <= wr_do ^ rd_do;
    end
end

assign wr_do = (state == ST_WRITE) && wr_en && !full;
assign rd_do = (state == ST_READ)  && rd_en && !empty;

always_comb begin
    next_state = state;
    unique case (state)
        ST_IDLE: begin
            if (wr_en && !full && rd_en && !empty) begin
                next_state = ST_WRITE;
            end else if (wr_en && !full) begin
                next_state = ST_WRITE;
            end else if (rd_en && !empty) begin
                next_state = ST_READ;
            end
        end
        ST_WRITE: begin
            if (rd_en && !empty) begin
                next_state = ST_IDLE;
            end else if (!wr_en || full) begin
                next_state = ST_IDLE;
            end
        end
        ST_READ: begin
            if (wr_en && !full) begin
                next_state = ST_IDLE;
            end else if (!rd_en || empty) begin
                next_state = ST_IDLE;
            end
        end
    endcase
end

endmodule