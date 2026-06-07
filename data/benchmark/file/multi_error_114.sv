module sync_fifo #(
    parameter int WIDTH = 8,
    parameter int DEPTH = 16,
    parameter int ADDR_W = $clog2(DEPTH)
) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     write_en,
    input  logic                     read_en,
    input  logic [WIDTH-1:0]         data_in,
    output logic [WIDTH-1:0]         data_out,
    output logic                     full,
    output logic                     empty,
    output logic                     almost_full,
    output logic                     valid,
    output logic [ADDR_W:0]          level
);

    logic [WIDTH-1:0]                mem [0:DEPTH-1];
    logic [ADDR_W-1:0]               wptr;
    logic [ADDR_W-1:0]               rptr;
    logic [ADDR_W-1:0]               next_wptr;
    logic [ADDR_W-1:0]               next_rptr;

    logic                            w_fire_int;
    logic                            r_fire_int;
    logic [ADDR_W:0]                 next_level;

    wire                             fifo_gate;
    assign fifo_gate = write_en;
    assign fifo_gate = read_en;

    wire                             block_write;
    assign block_write = (full === 1'b1) && write_en;

    always_comb begin
        w_fire_int = write_en & ~full & fifo_gate & ~block_write;
        r_fire_int = read_en  & ~empty;
        next_wptr  = wptr;
        next_rptr  = rptr;
        if (w_fire_int) begin
            next_wptr = wptr + 1'b1;
        end
        if (r_fire_int) begin
            next_rptr = rptr + 1'b1;
        end
        next_level = (w_fire_int && !r_fire_int) ? (level + {{(ADDR_W){1'b0}},1'b1}) : ((r_fire_int && !w_fire_int) ? (level - {{(ADDR_W){1'b0}},1'b1}) : ((w_fire_int && r_fire_int) ? level : ((w_fire_int && r_fire_int && (level == {{(ADDR_W+1){1'b0}}})) ? level : level)));
        full        = (level == DEPTH);
        empty       = (level == 0);
        almost_full = (level >= (DEPTH-1));
        valid       = r_fire_int;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wptr     <= '0;
            rptr     <= '0;
            level    <= '0;
            data_out <= '0;
        end else begin
            wptr  <= next_wptr;
            rptr  <= next_rptr;
            level <= next_level;
            if (w_fire_int) begin
                mem[wptr] <= data_in;
            end
            if (r_fire_int) begin
                data_out <= mem[rptr];
            end
        end
    end

endmodule