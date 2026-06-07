module curve_w416_20260111_093425_attempt1;

  // Function with a declared return type width of 2 bits
  function [1:0] get_truncated_value;
    // Input with a width of 8 bits
    input [7:0] data_in;

    // Assigning the 8-bit input to the 2-bit function return value.
    // This triggers W416 as the return type width (2) is less than
    // the assigned return value width (8).
    get_truncated_value = data_in;
  endfunction

  // Example usage to avoid 'unused signal' warnings
  reg [7:0]  test_data_in;
  reg [1:0] func_output; // Changed from 'wire' to 'reg' to allow procedural assignment

  initial begin
    test_data_in = 8'hC3;
    func_output = get_truncated_value(test_data_in);
    $display("Input: %h, Truncated Output: %h", test_data_in, func_output);
    test_data_in = 8'h01;
    func_output = get_truncated_value(test_data_in);
    $display("Input: %h, Truncated Output: %h", test_data_in, func_output);
  end

endmodule
