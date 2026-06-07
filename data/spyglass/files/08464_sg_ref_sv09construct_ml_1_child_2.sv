module sv09_ex1;
 int a;
 initial begin
  a = $urandom_range(3, 1);
 end
endmodule
