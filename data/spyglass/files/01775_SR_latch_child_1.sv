module sr_latch(S,R,Q,Qbar);
  
input S,R;
output reg Q,Qbar; // Declare Q and Qbar as 'reg' for use in always block
  
always @* begin
  // Implement the SR latch using cross-coupled NOR gate logic
  Q = ~(R | Qbar);
  Qbar = ~(S | Q);
end
  
endmodule
