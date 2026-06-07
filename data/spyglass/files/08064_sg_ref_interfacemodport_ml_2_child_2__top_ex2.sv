module top_ex2;
 my_interface i_if();
 sub_module_ex2 inst (i_if.master);

 // Fix SpyGlass W528: Variable 'i_if.sig' set but not read.
 // Add a synthesizable statement to read the value of i_if.sig.
 wire unused_read_i_if_sig = i_if.sig; // This resolves W528 for synthesis

 `ifdef SIMULATION
 initial begin
  #1; // Wait for the assignment to propagate
  $display("At time %0t: i_if.sig = %b", $time, i_if.sig);
 end
 `endif
 endmodule
