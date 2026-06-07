module delay_z_violation ();
  reg output_data;

  initial begin
    output_data = 1'b0;
    #1 output_data = 1'b1; // Delay value was 'z', now fixed to 1
  end
endmodule
