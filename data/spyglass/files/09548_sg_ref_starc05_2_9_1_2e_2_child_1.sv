module star_ex2;
 integer i; // Changed from reg to integer to resolve W480 and adhere to STARC05-2.9.1.2e
 initial begin
  for (i = 0; i < 2; i = i + 1) begin
  end
  $display("i = %0d", i);
 end
endmodule
