module test_real_naming_violation_1();
  real my_real_var;

  initial begin
    my_real_var = 3.14;
    $display("Value: %f", my_real_var);
  end
endmodule
