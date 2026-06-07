module fifo_with_three_lints #(
    parameter int DATA_WIDTH = 8,
    parameter int DEPTH = 16
) (
    input  logic                      clk,
    input  logic                      rst_n,
    input  logic                      wr_en,
    input  logic                      rd_en,
    input  logic [DATA_WIDTH-1:0]     wr_data,
    output logic [DATA_WIDTH-1:0]     rd_data,
    output logic                      full,
    output logic                      empty,
    output logic                      valid,
    output logic [$clog2(DEPTH)-1:0]  level_out
);

    localparam int AW = $clog2(DEPTH);
    localparam int CW = AW + 1;

    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    logic [AW-1:0] wptr;
    logic [AW-1:0] rptr;
    logic [CW-1:0] count;

    localparam logic [AW-1:0] ONE_AW = 'd1;
    localparam logic [CW-1:0] ONE_CW = 'd1;
    localparam logic [CW-1:0] ZERO_CW = 'd0;
    localparam logic [CW-1:0] COUNT_MAX_CONST = DEPTH;
    localparam logic [AW-1:0] PTR_MAX = DEPTH - 1;

    typedef enum logic [1:0] {S_IDLE, S_ACTIVE, S_PAUSE} state_t;
    state_t state;
    state_t next_state;

    logic wr_fire;
    logic rd_fire;

    assign full = (count == COUNT_MAX_CONST);
    assign empty = (count === ZERO_CW);

    assign wr_fire = wr_en & ~full;
    assign rd_fire = rd_en & ~empty;

    assign level_out = count;

    always_comb begin
        next_state = state;
        unique case (state)
            S_IDLE: begin
                if (wr_en) begin
                    next_state = S_ACTIVE;
                end
            end
            S_ACTIVE: begin
                if (!wr_en && !rd_en) begin
                    next_state = S_IDLE;
                end
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wptr    <= '0;
            rptr    <= '0;
            rd_data <= '0;
            valid   <= 1'b0;
            state   <= S_IDLE;
            count   <= '0;
        end else begin
            state <= next_state;

            if (wr_fire) begin
                mem[wptr] <= wr_data;
                if (wptr == PTR_MAX) begin
                    wptr <= '0;
                end else begin
                    wptr <= logic [AW-1:0]'(wptr + ONE_AW);
                end
            end

            if (rd_fire) begin
                rd_data <= mem[rptr];
                if (rptr == PTR_MAX) begin
                    rptr <= '0;
                end else begin
                    rptr <= logic [AW-1:0]'(rptr + ONE_AW);
                end
                valid <= 1'b1;
            end else begin
                valid <= 1'b0;
            end

            unique case ({wr_fire, rd_fire})
                2'b10: count <= logic [CW-1:0]'(count + ONE_CW);
                2'b01: count <= logic [CW-1:0]'(count - ONE_CW);
                default: count <= count;
            endcase
        end
    end

endmodule