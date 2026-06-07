// This module is intentionally defined with an empty body.
// SpyGlass will flag this definition with WarnAnalyzeBBox because it has an interface but no internal logic.
module empty_blackbox_module (
    input wire clk_i,
    input wire rst_ni,
    output wire data_o
);
    // No internal logic, assignments, or instantiations within this module.
    // This mimics a black-box or an incomplete design unit.
endmodule
