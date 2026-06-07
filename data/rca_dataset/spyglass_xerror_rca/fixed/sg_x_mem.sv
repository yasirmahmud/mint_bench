module sg_x_mem #(
    parameter int DATA_W = 8,
    parameter int DEPTH  = 8,
    parameter int ADDR_W = (DEPTH <= 1) ? 1 : $clog2(DEPTH)
) (
    input  logic              clk,
    input  logic              rst_n,
    input  logic [ADDR_W-1:0]  addr,
    output logic [DATA_W-1:0]  rdata
);
    import sg_x_pkg::*;

    logic [DATA_W-1:0] mem [0:DEPTH-1];
    int unsigned i;
    logic [DATA_W-1:0] rdata_next;

    always_comb begin
        for (i = 0; i < DEPTH; i++) begin
            mem[i] = DATA_W'(i);
        end

        // Array indexing propagation: addr is used as the memory index.
        rdata_next = mem[addr];
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rdata <= DATA_W'(RESET_SEED);
        end else begin
            rdata <= rdata_next;
        end
    end
endmodule
