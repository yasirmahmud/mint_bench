module w314_ex1(output out_s);
 reg [1:0] multi_reg;
 initial begin
  multi_reg = 2'b0; // Initialize multi_reg to a known value
 end
 assign out_s = multi_reg[0]; // Explicitly connect the LSB to out_s
endmodule
