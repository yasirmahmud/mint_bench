module curve_w215_20260111_002217_attempt1 ();

  integer my_int;
  reg out_bit;

  initial begin
    my_int = 32'd10; // Assign a value to the integer
    out_bit = my_int[0]; // This bit selection on an integer should trigger W215
  end

endmodule
