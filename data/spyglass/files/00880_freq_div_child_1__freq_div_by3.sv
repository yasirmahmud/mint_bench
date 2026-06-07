// Original freq_div_by3 module
module freq_div_by3(
    input clk, reset,
    output clk_by3
    );
    wire[1:0] q;
    wire temp; 
    
    // Instantiate the mod-3 counter
    mod_3_counter M3C(clk, reset, q);
    
    // Instantiate the D flip-flop.
    // The DFF's clock is the inverse of the main clock (~clk),
    // so it acts as a negative-edge triggered flip-flop with respect to 'clk'.
    // Its data input is q[1] and output is 'temp'.
    D_flipflop D(~clk, reset, q[1], temp);
    
    // The output clk_by3 is the OR of q[1] and temp (DFF output)
    or(clk_by3, q[1], temp);
    
endmodule
