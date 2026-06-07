module curve_stx_ve_300_20260111_095832_attempt1 ();
  const int my_const_var = 10;

  initial begin
    my_const_var = 20; // Illegal re-assignment to a const variable
  end

endmodule
