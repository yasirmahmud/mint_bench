module rule_26_1_ex1 ();
 wire my_signal;
 my_lib_cell u_cell (.in_pin(1'b1), .out_pin(my_signal));

 initial begin
  // Reading 'my_signal' to resolve W528 violation
  $display("At time %0t, my_signal = %b", $time, my_signal);
 end
 endmodule
