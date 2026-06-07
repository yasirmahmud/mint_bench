module curve_stx_ve_775_20260110_151647_attempt3 (
  input wire [7:0] in_a,
  input wire [7:0] in_c,
  output wire [7:0] out_b,
  output wire [7:0] out_d
);

  // First function where an 'initial' block is not allowed in Verilog-2001.
  // This should trigger the first STX_VE_775 violation.
  function [7:0] my_func_1;
    input [7:0] data_in;
    initial begin
      $display("Violation 1: Initial block inside function my_func_1 for data_in = %h", data_in);
    end
    my_func_1 = data_in + 1;
  endfunction

  // Second function where an 'initial' block is also not allowed.
  // This should trigger the second STX_VE_775 violation, meeting the "Total occurrences: 2" requirement.
  function [7:0] my_func_2;
    input [7:0] data_in;
    initial begin
      $display("Violation 2: Initial block inside function my_func_2 for data_in = %h", data_in);
    end
    my_func_2 = data_in - 1;
  endfunction

  // Use both functions to ensure all input/output ports are connected and avoid unused signal warnings.
  assign out_b = my_func_1(in_a);
  assign out_d = my_func_2(in_c);

endmodule
