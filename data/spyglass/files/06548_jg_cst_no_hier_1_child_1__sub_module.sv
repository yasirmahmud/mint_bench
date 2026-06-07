module sub_module (
    input wire clk
);
    parameter P1 = 10;
    // Fix for W240: Input 'clk' declared but not read. Add a dummy usage.
    wire _unused_clk = clk;
endmodule
