module PortComment_ex1 (
    input clk // The main system clock input
);
    // Dummy assignment to prevent 'clk' from being reported as unused (W240)
    wire unused_clk_sink = clk;

endmodule
