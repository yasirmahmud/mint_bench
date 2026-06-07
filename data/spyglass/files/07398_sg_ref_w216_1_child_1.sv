module w216_ex1;
 reg [31:0] i; // Changed 'integer' to 'reg [31:0]' to resolve W215 and W528
 initial begin
  i = 10;
  $display("%d", i[0]);
 end
endmodule
