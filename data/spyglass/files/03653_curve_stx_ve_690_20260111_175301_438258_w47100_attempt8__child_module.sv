// Child module definition with simple pass-through logic
module child_module (
  input  in_bit,   // A single-bit input
  output out_bit   // A single-bit output
);
  assign out_bit = in_bit;
endmodule
