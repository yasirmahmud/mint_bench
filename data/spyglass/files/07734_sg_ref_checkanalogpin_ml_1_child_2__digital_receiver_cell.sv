module digital_receiver_cell (input wire digital_in);
 // Fix: Add a dummy register to consume the unused input and prevent "empty definition" warning.
 // This maintains the original functional behavior where the input has no external effect.
 reg digital_in_sink_reg;
 always @(*) begin
  digital_in_sink_reg = digital_in;
 end
 endmodule
