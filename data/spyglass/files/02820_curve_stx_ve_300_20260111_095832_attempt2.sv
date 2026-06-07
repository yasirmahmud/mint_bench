module curve_stx_ve_300_20260111_095832_attempt2 ();
  const logic [1:0] my_fixed_val = 2'b10;

  always @* begin
    my_fixed_val = 2'b01; // Illegal re-assignment to a const variable
  end

endmodule
