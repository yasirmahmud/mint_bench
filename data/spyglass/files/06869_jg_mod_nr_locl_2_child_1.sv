module mod_nr_locl_example_2;

  // Changed 'task' to 'function' to resolve W528 (variable set but not read) by returning the processed data.
  // Removed inline initialization of 'processed_data' to resolve the MOD_NR_LOCL violation.
  function automatic bit [7:0] my_data_processor(input bit [7:0] data_in);
    reg [7:0] processed_data; // MOD_NR_LOCL fixed: Declaration without inline initialization
    processed_data = data_in ^ 8'hFF; // Assignment after declaration
    $display("Original: %h, Processed: %h", data_in, processed_data);
    return processed_data; // W528 fixed: 'processed_data' is read as the return value
  endfunction

  initial begin
    // SYNTH_5143: Initial block is ignored for synthesis. This is a simulation-only construct.
    // This block is preserved to maintain the described functional behavior (display output during simulation).
    bit [7:0] function_output;
    function_output = my_data_processor(8'hA5); // Call the function and store its return value
  end

endmodule
