module divide_by_3(
    input clk,reset,
    output q
    );
    
    wire w1,w2;
    wire qbar,qbar1,qbar2,q1,q2;
     
    d_ff a1(w2,clk,reset,w1,qbar1);
    d_ff a2(w1,clk,reset,q1,qbar);
    and a3(w2,qbar1,qbar);
    d_ff a4(q1,~clk,reset,q2,qbar2);
    or a5(q,q1,q2);
    
endmodule
