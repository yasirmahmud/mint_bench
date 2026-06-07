module delay_z_violation ();
  reg output_data;

  initial begin
    output_data = 1'b0;
    #1'bz output_data = 1'b1; // Delay value contains 'z'
  end
endmodule
