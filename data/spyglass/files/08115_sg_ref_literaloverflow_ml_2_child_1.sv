module literal_overflow_ex2;
 wire [3:0] my_signal;
 assign my_signal = 4'b0101; // Fix W19: Literal 4'b10101 truncates to 4'b0101. Explicitly assign the truncated value to preserve behavior.
 
 initial begin
   $display("my_signal = %b", my_signal); // Fix W528: Read my_signal to prevent 'set but not read' warning.
 end
endmodule
