module string_var_example_1();
  string my_message = "Hello World";

  initial begin
    $display("%s", my_message);
  end
endmodule
