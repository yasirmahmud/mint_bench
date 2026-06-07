module curve_synth_5036_20260110_153204_attempt2 (
    input wire [7:0] in1,
    input wire [7:0] in2,
    output wire [7:0] out_data1,
    output wire [7:0] out_data2
);

  // First function causing SYNTH_5036 violation
  // By default, Verilog-2001 functions are static.
  function [7:0] my_sum_func1 (input [7:0] a, input [7:0] b);
    begin
      // SYNTH_5036 violation #1: Non-blocking assignment to a function's return value.
      // Synthesis tools typically treat this as a blocking assignment.
      my_sum_func1 <= a + b;
    end
  endfunction

  // Second function causing SYNTH_5036 violation to meet the total occurrence count of 2
  function [7:0] my_sum_func2 (input [7:0] a, input [7:0] b);
    begin
      // SYNTH_5036 violation #2: Non-blocking assignment to a function's return value.
      my_sum_func2 <= a + b;
    end
  endfunction

  // Drive module outputs using the functions to ensure all signals are utilized.
  assign out_data1 = my_sum_func1(in1, in2);
  assign out_data2 = my_sum_func2(in1, in2);

endmodule
