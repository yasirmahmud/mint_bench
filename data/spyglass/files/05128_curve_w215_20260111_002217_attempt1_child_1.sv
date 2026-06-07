module curve_w215_20260111_002217_attempt1 ();

  integer my_int;
  reg out_bit;

  initial begin
    my_int = 32'd10; // Assign a value to the integer
    out_bit = my_int & 1'b1; // Use bitwise AND to get the LSB, resolves W215
    $display("out_bit value is: %b", out_bit); // Dummy read to resolve W528
  end

endmodule
