module fifo_with_lint #(parameter DATA_WIDTH = 8, parameter DEPTH = 16) (
    input  logic                     clk,
    input  logic                     reset_n,
    input  logic                     wr_en,
    input  logic                     rd_en,
    input  logic [DATA_WIDTH-1:0]    din,
    output logic [DATA_WIDTH-1:0]    dout,
    output logic                     full,
    output logic                     empty,
    output wire  [7:0]               status_out
);

    localparam int ADDR_BITS = $clog2(DEPTH);

    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    logic [ADDR_BITS:0] wr_ptr;
    logic [ADDR_BITS:0] rd_ptr;
    logic [ADDR_BITS:0] next_wr_ptr;
    logic [ADDR_BITS:0] next_rd_ptr;

    wire  [ADDR_BITS-1:0] wr_idx = wr_ptr[ADDR_BITS-1:0];
    wire  [ADDR_BITS-1:0] rd_idx = rd_ptr[ADDR_BITS-1:0];

    wire  [7:0] status_bus;
    logic       bogus_reg;

    assign bogus_reg = full;

    assign status_bus = {6'b000000, bogus_reg, full};
    assign status_bus = 8'h00;

    assign status_out = status_bus;

    always_comb begin
        empty = (wr_ptr == rd_ptr);
        full  = ((wr_ptr[ADDR_BITS-1:0] == rd_ptr[ADDR_BITS-1:0]) && (wr_ptr[ADDR_BITS] != rd_ptr[ADDR_BITS]));
    end

    always @(wr_en or rd_en) begin
        next_wr_ptr = wr_ptr;
        if (wr_en && !full) begin
            next_wr_ptr = wr_ptr + 1'b1;
        end
    end

    always_comb begin
        next_rd_ptr = rd_ptr;
        if (rd_en && !empty) begin
            next_rd_ptr = rd_ptr + 1'b1;
        end
    end

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            wr_ptr <= '0;
            rd_ptr <= '0;
        end else begin
            wr_ptr <= next_wr_ptr;
            rd_ptr <= next_rd_ptr;
            if (wr_en && !full) begin
                mem[wr_idx] <= din;
            end
        end
    end

    always @(*) begin
        if (rd_en && !empty) begin
            dout = mem[rd_idx];
        end
    end

endmodule