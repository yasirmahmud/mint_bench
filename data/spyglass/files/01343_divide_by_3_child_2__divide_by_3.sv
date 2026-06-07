module divide_by_3(
    input clk,reset,
    output q
    );
    
    wire w1,w2;
    wire qbar,qbar1,q1,q2; 
    wire _unused_qbar2;    // Dummy wire to connect unused output 'qbar2'
     
    d_ff a1(w2,clk,reset,w1,qbar1);
    d_ff a2(w1,clk,reset,q1,qbar);
    and a3(w2,qbar1,qbar);
    d_ff a4(q1,~clk,reset,q2,_unused_qbar2); // Connected 'Qbar' output to dummy wire
    or a5(q,q1,q2);
    
endmodule
