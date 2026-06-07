module curve_stx_ve_627_20260110_225629_attempt1;

  // Function requiring two 8-bit input arguments
  function automatic [7:0] my_func;
    input [7:0] in1;
    input [7:0] in2;
    my_func = in1 + in2;
  endfunction

  reg [7:0] result_data; // Declare a register to store function results

  initial begin
    // Violation 1: Calling my_func with only one argument (expected two)
    result_data = my_func(8'd5);

    // Violation 2: Calling my_func with only one argument (expected two)
    result_data = my_func(8'd10);

    // Violation 3: Calling my_func with only one argument (expected two)
    result_data = my_func(8'd15);

    $display("Result: %d", result_data);
    $finish;
  end

endmodule
