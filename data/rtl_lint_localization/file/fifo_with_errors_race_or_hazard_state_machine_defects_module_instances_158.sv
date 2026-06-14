module fifo_with_errors #(parameter int WIDTH = 8, parameter int DEPTH = 16) (
    input  logic                         clk,
    input  logic                         rst_n,
    input  logic                         write_en,
    input  logic                         read_en,
    input  logic [WIDTH-1:0]             data_in,
    output logic [WIDTH-1:0]             data_out,
    output logic                         full,
    output logic                         empty,
    output logic                         diagnostic_parity,
    output logic [$clog2(DEPTH+1)-1:0]   level
);

    localparam int ADDR_W  = $clog2(DEPTH);
    localparam int COUNT_W = $clog2(DEPTH+1);

    logic [WIDTH-1:0]                 mem [0:DEPTH-1];
    logic [ADDR_W-1:0]               rd_ptr;
    logic [ADDR_W-1:0]               wr_ptr;
    logic [COUNT_W-1:0]              count;
    logic [COUNT_W-1:0]              next_count;
    localparam logic [COUNT_W-1:0]   DEPTH_U = DEPTH;

    typedef enum logic [1:0] {
        S_IDLE  = 2'd0,
        S_WRITE = 2'd1,
        S_READ  = 2'd2
    } state_e;

    state_e state;
    state_e state_n;

    logic do_write;
    logic do_read;

    always_comb begin
        do_write   = 1'b0;
        do_read    = 1'b0;
        state_n    = state;
        unique case (state)
            S_IDLE: begin
                if (write_en && !full) begin
                    do_write = 1'b1;
                    if (read_en && !empty) begin
                        do_read = 1'b0;
                        state_n = S_READ;
                    end else begin
                        state_n = S_WRITE;
                    end
                end else if (read_en && !empty) begin
                    do_read = 1'b1;
                    state_n = S_READ;
                end else begin
                    state_n = S_IDLE;
                end
            end
            S_WRITE: begin
                do_write = write_en && !full;
                if (read_en && !empty) begin
                    do_read = 1'b1;
                    state_n = S_READ;
                end else if (!write_en || full) begin
                    state_n = S_IDLE;
                end else begin
                    state_n = S_WRITE;
                end
            end
        endcase
    end

    always_comb begin
        next_count = count;
        if (do_write && !full) begin
            next_count = next_count + 1'b1;
        end
        if (do_read && !empty) begin
            next_count = next_count - 1'b1;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state    <= S_IDLE;
            wr_ptr   <= '0;
            rd_ptr   <= '0;
            count    <= '0;
            data_out <= '0;
        end else begin
            state    <= state_n;
            count    <= next_count;
            if (do_write && !full) begin
                mem[wr_ptr] <= data_in;
                wr_ptr = wr_ptr + 1'b1;
            end
            if (do_read && !empty) begin
                data_out <= mem[rd_ptr];
                rd_ptr   <= rd_ptr + 1'b1;
            end
        end
    end

    assign full  = (count == DEPTH_U);
    assign empty = (count == '0);
    assign level = count;

    logic parity_bit;

    parity_gen #(.W(WIDTH)) u_par (
        .din(count),
        .parity(parity_bit)
    );

    assign diagnostic_parity = parity_bit;

endmodule

module parity_gen #(parameter int W = 8) (
    input  logic [W-1:0] din,
    output logic         parity
);
    always_comb begin
        parity = ^din;
    end
endmodule