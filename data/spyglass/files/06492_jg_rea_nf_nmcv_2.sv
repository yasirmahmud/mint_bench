module test_real_naming_violation_2();
  real temperature;

  initial begin
    temperature = 25.5;
    $display("Temperature: %f C", temperature);
  end
endmodule
