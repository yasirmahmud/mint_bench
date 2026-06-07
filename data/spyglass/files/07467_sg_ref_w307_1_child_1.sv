module W307_ex1;
 reg [7:0] my_reg;
 real my_real;
 initial begin 
  my_reg = 8'hFF;
  my_real = my_reg;
  $display("my_real = %f", my_real); // Added to resolve W528: Variable 'my_real' set but not read.
 end 
endmodule
