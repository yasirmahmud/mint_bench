module decade_counter(
    input clk,rst,
    output [3:0] q
    );
   wire w1,w2,w3,w4,w5;
   wire t0_enable = 1'b1; // Introduce a named wire for T0 to resolve FlopEConst violation
    assign w1=~(q[3])& q[0];
     assign w2=(~q[3])&q[1] &q[0];
     assign w3=(~q[3]) &q[2]&q[1]&q[0];
     assign w4=q[3] &(~q[2]) &(~q[1]) &q[0];
     assign w5= w3| w4;
   t_flipflop1 a1(t0_enable,clk,rst,q[0]); // Use the named wire for T0
  
   t_flipflop1 a2(w1,clk,rst,q[1]);
  
  t_flipflop1 a3(w2,clk,rst,q[2]);
  
   t_flipflop1 a4(w5,clk,rst,q[3]);
   
    
endmodule
