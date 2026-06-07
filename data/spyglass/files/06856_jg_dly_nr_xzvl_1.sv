module delay_x_violation ();
  reg my_signal;

  initial begin
    my_signal = 1'b0;
    #1'bx my_signal = 1'b1; // Delay value contains 'x'
  end
endmodule
