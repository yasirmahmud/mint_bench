module string_var_example_2();
  string error_code;

  initial begin
    error_code = "E1001";
    $display("Error: %s", error_code);
  end
endmodule
