module jk_ms_ff  (Q, Qb, J, K, Clk, Set, Rst);

  
  input J,K,Clk,Rst,Set;
  output  Q,Qb;
  
  wire Clkb,MQ,MQb,MSet,MRst,SSet,SRst;
  
  not gen(Clkb, Clk);
  
  nand m1(MRst,Clk,J,Qb);
  nand m2(MSet,Clk,K,Q);
  nand m3(MQ,MRst,MQb);
  nand m4(MQb,MSet,MQ);
  nand m5(SRst,Clkb,MQ);
  nand m6(SSet,Clkb,MQb);
  nand m7(Q,Qb,SRst,Set);
  nand m8(Qb,Q,SSet,Rst);
  
  
endmodule
