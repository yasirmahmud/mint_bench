module fifo_qc #(
    parameter int WIDTH = 8,
    parameter int DEPTH = 20
) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 wr_en,
    input  logic                 rd_en,
    input  logic [WIDTH-1:0]     din,
    output logic [WIDTH-1:0]     dout,
    output logic                 full,
    output logic                 empty,
    output logic                 almost_full,
    output logic [$clog2(DEPTH):0] count
);

    localparam int AW = $clog2(DEPTH);
    localparam int CW = AW + 1;

    logic [WIDTH-1:0] mem [0:DEPTH-1];

    logic [AW-1:0] wr_ptr;
    logic [AW-1:0] rd_ptr;
    logic [AW-1:0] wr_ptr_n;
    logic [AW-1:0] rd_ptr_n;

    logic [CW-1:0] count_n;

    logic wr_fire;
    logic rd_fire;

    logic [WIDTH-1:0] dout_n;

    logic [WIDTH-1:0] unused_probe;

    assign wr_fire = wr_en & ~full;
    assign rd_fire = rd_en & ~empty;

    always_comb begin
        wr_ptr_n = wr_ptr;
        rd_ptr_n = rd_ptr;
        count_n  = count;

        if (wr_fire) begin
            wr_ptr_n = (wr_ptr + AW'(1)) % DEPTH;
        end

        if (rd_fire) begin
            rd_ptr_n = (rd_ptr == AW'(DEPTH-1)) ? '0 : (rd_ptr + AW'(1));
        end

        if (wr_fire & ~rd_fire) begin
            count_n = count + CW'(1);
        end else if (~wr_fire & rd_fire) begin
            count_n = count - CW'(1);
        end else begin
            count_n = count;
        end
    end

    always_comb begin
        if (rd_fire) dout_n = mem[rd_ptr];
    end

    assign empty = (count == '0);
    assign full  = (count == CW'(DEPTH));

    assign almost_full = (count >= CW'(DEPTH-1))

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            wr_ptr <= '0;
            rd_ptr <= '0;
            count  <= '0;
            dout   <= '0;
        end else begin
            wr_ptr <= wr_ptr_n;
            rd_ptr <= rd_ptr_n;
            count  <= count_n;
            dout   <= dout_n;
            if (wr_fire) begin
                mem[wr_ptr] <= din;
            end
        end
    end

endmodule