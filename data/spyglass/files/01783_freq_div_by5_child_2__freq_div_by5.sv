module freq_div_by5(
    input clk, reset,
    output clk_by5
    );
    wire[2:0] q;
    wire temp; 
    
    mod_5_counter M5C(clk, reset, q);
    
    D_flipflop D(~clk, reset, q[1], temp);
    
    or(clk_by5, q[1], temp);
    
endmodule
