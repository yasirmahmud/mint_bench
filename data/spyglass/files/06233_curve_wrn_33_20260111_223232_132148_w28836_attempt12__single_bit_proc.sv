// Child module definition
module single_bit_proc (
  input wire in_bit,
  output wire out_bit
);
  assign out_bit = in_bit; // Simple buffer
endmodule
