module unused_function_example_1 (
  input logic clk,
  input logic rst_n,
  input logic [7:0] data_in,
  output logic [7:0] data_out
);

  function automatic int calculate_sum (input int a, input int b);
    return a + b;
  endfunction

  assign data_out = data_in;

endmodule
