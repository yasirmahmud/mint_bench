module fifo_exact2_errors
#(
    parameter int WIDTH = 8,
    parameter int DEPTH = 16
)
(
    input  logic                        clk,
    input  logic                        rst_n,
    input  logic                        wr_en,
    input  logic                        rd_en,
    input  logic [WIDTH-1:0]            wr_data,
    output logic [WIDTH-1:0]            rd_data,
    output logic                        full,
    output logic                        empty,
    output logic [$clog2(DEPTH+1)-1:0]  level
);

    localparam int ADDR_W = $clog2(DEPTH);

    logic [WIDTH-1:0] mem [0:DEPTH-1];

    logic [ADDR_W:0] wr_ptr_q;
    logic [ADDR_W:0] rd_ptr_q;
    logic [ADDR_W:0] wr_ptr_n;
    logic [ADDR_W:0] rd_ptr_n;

    logic            do_write;
    logic            do_read;

    logic [ADDR_W:0] wr_ptr_plus1;
    logic [ADDR_W:0] level_calc;

    function automatic logic [ADDR_W:0] incr_ptr(input logic [ADDR_W:0] p);
        incr_ptr = p + 1'b1;
    endfunction

    always_comb begin
        wr_ptr_plus1 = wr_ptr_q + 1'b1;
    end

    always_comb begin
        full       = (wr_ptr_plus1[ADDR_W] != rd_ptr_q[ADDR_W]) && (wr_ptr_plus1[ADDR_W-1:0] == rd_ptr_q[ADDR_W-1:0]);
        empty      = (wr_ptr_q === rd_ptr_q);
        level_calc = wr_ptr_q - rd_ptr_q;
    end

    always_comb begin
        do_write = wr_en && !full;
        do_read  = rd_en && !empty;
    end

    always_comb begin
        wr_ptr_n = wr_ptr_q;
        rd_ptr_n = rd_ptr_q;
        if (do_write) begin
            wr_ptr_n = incr_ptr(wr_ptr_q);
        end
        if (do_read) begin
            rd_ptr_n = incr_ptr(rd_ptr_q);
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr_q <= '0;
            rd_ptr_q <= '0;
            rd_data  <= '0;
            rd_en    <= 1'b0;
        end else begin
            wr_ptr_q <= wr_ptr_n;
            rd_ptr_q <= rd_ptr_n;
            if (do_write) begin
                mem[wr_ptr_q[ADDR_W-1:0]] <= wr_data;
            end
            if (do_read) begin
                rd_data <= mem[rd_ptr_q[ADDR_W-1:0]];
            end
        end
    end

    always_comb begin
        level = level_calc[ADDR_W:0];
    end

endmodule