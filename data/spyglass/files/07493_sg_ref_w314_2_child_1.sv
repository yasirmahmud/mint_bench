module w314_ex2 (output out_sig);
 reg [3:0] data_reg;
 initial begin
  data_reg = 4'h0; // Initialize data_reg to resolve W123: Variable 'data_reg[3:0]' read but never set.
 end
 assign out_sig = data_reg;
 endmodule
