module top_w504_ex1;
  // Fix for W110 (Incompatible width for port 'in_port')
  // Explicitly sizing the literal to 8 bits resolves the width mismatch.
  sub_w504_ex1 u_sub (.in_port(8'd123));
endmodule
