module sv09_ex1;
 int a;
 initial begin
  randcase
   1'b1: a = 1;
   1'b1: a = 2;
   1'b1: a = 3;
  endcase
 end
endmodule
