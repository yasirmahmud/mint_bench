module PortComment_ex1 (
    input clk // The main system clock input
);
    // The previous dummy assignment 'wire unused_clk_sink = clk;' was intended to prevent
    // 'clk' from being reported as unused (W240). However, it introduced a new violation (W528)
    // because 'unused_clk_sink' itself was set but not read. Since W240 for 'clk' is not
    // listed as a current violation, and 'unused_clk_sink' served no functional purpose,
    // removing the dummy assignment resolves the W528 violation without changing functional behavior.

endmodule
