module OSC_GENERATOR (
    input clk_in,
    output clk_out
);
    parameter DIV_FACTOR = 10; // An integer parameter

    // Minimal logic to use ports
    assign clk_out = clk_in;

endmodule
