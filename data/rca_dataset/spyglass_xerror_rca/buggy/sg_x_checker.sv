module sg_x_checker #(
    parameter int DEPTH  = 8,
    parameter int ADDR_W = (DEPTH <= 1) ? 1 : $clog2(DEPTH)
) (
    input logic              clk,
    input logic              rst_n,
    input logic [ADDR_W-1:0]  addr,
    input logic              enable,
    output logic             addr_ok
);
    import sg_x_pkg::*;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            addr_ok <= ~RESET_SEED[0];
        end else if (enable) begin
            addr_ok <= (addr < DEPTH);

            // Assertion propagation: immediate check for valid address.
            // synopsys translate_off
            assert (addr < DEPTH)
                else $error("sg_x_checker: addr out of range");
            // synopsys translate_on
        end
    end
endmodule
