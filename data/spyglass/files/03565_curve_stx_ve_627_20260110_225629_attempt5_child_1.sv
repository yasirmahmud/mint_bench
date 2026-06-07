module curve_stx_ve_627_20260110_225629_attempt5;

  // Function requiring three integer input arguments
  function automatic integer process_data;
    input integer data_in1;
    input integer data_in2;
    input integer data_in3;
    process_data = data_in1 + data_in2 + data_in3;
  endfunction

  integer final_result; // Variable to store function results

  initial begin
    // CORRECT CALL: Calling process_data with the expected three arguments
    final_result = process_data(10, 20, 30);
    $display("Correct call result: %0d", final_result);

    // RESOLVED VIOLATION: Calling process_data with the correct number of arguments
    // The original code called process_data with too few arguments. Added a third argument (0) to resolve STX_VE_627.
    final_result = process_data(5, 15, 0);
    $display("Violation call result: %0d", final_result);

    $finish; // Terminate simulation
  end

endmodule
