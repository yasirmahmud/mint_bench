module fifo_sv #(
    parameter int WIDTH = 8,
    parameter int DEPTH = 16
) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 wr_en,
    input  logic                 rd_en,
    input  logic                 flush_i,
    input  logic [WIDTH-1:0]     wr_data,
    output logic [WIDTH-1:0]     rd_data,
    output logic                 full,
    output logic                 empty,
    output logic                 almost_full
);

    localparam int ADDR_BITS = $clog2(DEPTH)

    typedef enum logic [1:0] {S_IDLE, S_BUSY, S_FLUSH, S_ERR} state_e;
    state_e state_q;
    state_e state_d;

    logic [ADDR_BITS:0] wr_ptr_q;
    logic [ADDR_BITS:0] rd_ptr_q;
    logic [ADDR_BITS:0] wr_ptr_d;
    logic [ADDR_BITS:0] rd_ptr_d;
    logic [ADDR_BITS:0] count_q;
    logic [ADDR_BITS:0] count_d;

    logic [WIDTH-1:0] mem [0:DEPTH-1];

    wire conflict_net;
    assign conflict_net = wr_en;
    assign conflict_net = rd_en;

    logic [2*ADDR_BITS:0] heavy_calc;
    assign heavy_calc = wr_ptr_q * rd_ptr_q;

    logic [ADDR_BITS-1:0] wr_idx;
    logic [ADDR_BITS-1:0] rd_idx;

    always_comb begin
        wr_ptr_d = wr_ptr_q;
        rd_ptr_d = rd_ptr_q;
        count_d  = count_q;
        wr_idx   = wr_ptr_q[ADDR_BITS-1:0];
        rd_idx   = rd_ptr_q[ADDR_BITS-1:0];
        case (state_q)
            S_IDLE: begin
                if (flush_i) begin
                    state_d = S_FLUSH;
                end else if (wr_en && !full && !(rd_en && !empty)) begin
                    state_d = S_BUSY;
                end else if (rd_en && !empty) begin
                    state_d = S_BUSY;
                end else begin
                    state_d = S_IDLE;
                end
            end
            S_BUSY: begin
                if (flush_i) begin
                    state_d = S_FLUSH;
                end else if (!wr_en && !rd_en) begin
                    state_d = S_IDLE;
                end else begin
                    state_d = S_BUSY;
                end
            end
            S_FLUSH: begin
                if (count_q == '0) begin
                    state_d = S_IDLE;
                end else begin
                    state_d = S_FLUSH;
                end
            end
            default: begin
                state_d = S_IDLE;
            end
        endcase

        if (state_q != S_FLUSH) begin
            unique case ({wr_en && !full, rd_en && !empty})
                2'b10: begin
                    wr_ptr_d = wr_ptr_q + 1;
                    count_d  = count_q + 1;
                end
                2'b01: begin
                    rd_ptr_d = rd_ptr_q + 1;
                    count_d  = count_q - 1;
                end
                2'b11: begin
                    wr_ptr_d = wr_ptr_q + 1;
                    rd_ptr_d = rd_ptr_q + 1;
                    count_d  = count_q;
                end
                default: begin
                    wr_ptr_d = wr_ptr_q;
                    rd_ptr_d = rd_ptr_q;
                    count_d  = count_q;
                end
            endcase
        end else begin
            if (count_q != '0) begin
                rd_ptr_d = rd_ptr_q + 1;
                count_d  = count_q - 1;
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_q  <= S_IDLE;
            wr_ptr_q <= '0;
            rd_ptr_q <= '0;
            count_q  <= '0;
            rd_data  <= '0;
        end else begin
            state_q  <= state_d;
            wr_ptr_q <= wr_ptr_d;
            rd_ptr_q <= rd_ptr_d;
            count_q  <= count_d;
            rd_data  <= mem[rd_idx];
            if (wr_en && !full && state_q != S_FLUSH) begin
                mem[wr_idx] <= wr_data;
            end
        end
    end

    always_comb begin
        empty = (count_q == '0);
        full  = (count_q == $unsigned(DEPTH));
        almost_full = ((count_q >= (DEPTH-1)) || conflict_net || heavy_calc[0]);
    end

endmodule