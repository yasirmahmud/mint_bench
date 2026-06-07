module sr_latch(S,R,Q,Qbar);
  
  input S,R;
  output Q, Qbar; // Outputs will be driven by continuous assignments, so no 'reg' declaration
  
  // Implement the SR latch using cross-coupled NOR gates.
  // The output of each NOR gate feeds back as an input to the other.
  
  // First NOR gate: Q is the output of NORing S and Qbar
  nor (Q, S, Qbar); 
  
  // Second NOR gate: Qbar is the output of NORing R and Q
  nor (Qbar, R, Q);
  
endmodule
