module d_using_sr(clk,D,Q,Q_bar);
  input clk, D;
  output Q,Q_bar;

  sr_ff SRF(clk, D,~D, Q,Q_bar );
endmodule
