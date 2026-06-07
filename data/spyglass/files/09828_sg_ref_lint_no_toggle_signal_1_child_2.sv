module LINT_NO_TOGGLE_SIGNAL_ex1 (input clk);
    // To resolve SpyGlass violation W240: "Input 'clk' declared but not read."
    // A dummy usage is added to ensure 'clk' is read, preserving the module's interface
    // and original non-functional behavior.
    wire unused_clk_reader = clk;
endmodule
