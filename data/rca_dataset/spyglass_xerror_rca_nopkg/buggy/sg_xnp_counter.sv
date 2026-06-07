module sg_xnp_counter #(
    parameter int DEPTH  = 8,
    parameter int ADDR_W = (DEPTH <= 1) ? 1 : $clog2(DEPTH),
    parameter logic [31:0] RESET_SEED = '0
) (
    input  logic clk,
    input  logic rst_n,
    input  logic enable,
    output logic [ADDR_W-1:0] addr
);
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            addr <= RESET_SEED[ADDR_W-1:0];
        end else if (enable) begin
            addr <= addr + {{(ADDR_W - 1) {1'b0}}, 1'b1};
        end
    end
endmodule

