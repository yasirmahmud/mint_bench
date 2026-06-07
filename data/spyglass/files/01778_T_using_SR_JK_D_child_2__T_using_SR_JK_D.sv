module T_using_SR_JK_D(
    input clk, reset, T,
    output Q_sr, Q_jk, Q_d
    );
    wire w1, w2, w3;
    
    // Q_sr, Q_jk, Q_d are output wires by default and are connected to reg outputs of the instantiated modules.
    
    assign w1= T & (~Q_sr);
    assign w2= T & Q_sr;
    SR_flipflop SR(clk, reset, w1, w2, Q_sr);
    
    JK_flipflop JK(T, T, clk, reset, Q_jk);
    
    assign w3= T ^ Q_d;
    D_flipflop D(clk, reset,w3, Q_d);
    
endmodule
