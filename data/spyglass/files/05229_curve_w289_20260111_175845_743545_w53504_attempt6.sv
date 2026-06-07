module curve_w289_20260111_175845_743545_w53504_attempt6 ();

  real my_real_var;
  real another_real_var;
  reg out_signal_a;
  reg out_signal_b;

  initial begin
    my_real_var = 10.5;
    another_real_var = 5.0;

    // W289 violation 1: Comparing a real variable with a real literal
    if (my_real_var == 10.5) begin
      out_signal_a = 1;
    end else begin
      out_signal_a = 0;
    end

    // W289 violation 2: Comparing two real variables
    if (another_real_var == my_real_var) begin
      out_signal_b = 1;
    end else begin
      out_signal_b = 0;
    end
  end

endmodule
