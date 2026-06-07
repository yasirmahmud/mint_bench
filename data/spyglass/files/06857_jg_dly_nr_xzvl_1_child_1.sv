module delay_x_violation ();
  reg my_signal;

  initial begin
    my_signal = 1'b0;
    #1 my_signal = 1'b1; // Delay value was 'x', changed to 1 to fix syntax and DLY_NR_XZVL violation
  end
endmodule
