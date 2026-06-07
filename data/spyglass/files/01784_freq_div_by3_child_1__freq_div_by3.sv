module freq_div_by3(
    input clk, reset,
    output clk_by3
    );
    wire[1:0] q;
    wire temp; 
    
    mod_3_counter M3C(clk, reset, q);
    
    D_flipflop D(~clk, reset, q[1], temp);
    
    or(clk_by3, q[1], temp);
    
endmodule
