module real_func_example_1;
  function real get_real_value();
    return 1.234;
  endfunction

  initial begin
    real my_value;
    my_value = get_real_value();
    $display("Real value: %f", my_value);
  end
endmodule
