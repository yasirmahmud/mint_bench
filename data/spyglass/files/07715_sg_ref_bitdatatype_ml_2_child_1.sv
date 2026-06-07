module bit_datatype_ex2();
 bit my_signal;
 assign my_signal = 1'b0;

 initial begin
  // Reading my_signal to resolve W528 'set but not read' violation
  $display("my_signal initialized to: %b", my_signal);
 end

 endmodule
