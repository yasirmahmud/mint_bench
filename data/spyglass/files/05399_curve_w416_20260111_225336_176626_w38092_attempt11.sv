module curve_w416_20260111_225336_176626_w38092_attempt11 (
  input wire [6:0] data_in,
  output wire [2:0] result_out
);

  // Function 'process_data' has a return type width of 3 bits ([2:0]).
  function [2:0] process_data;
    input [6:0] source_data; // 'source_data' is 7 bits wide ([6:0]).
    begin
      // W416 violation: The return type width (3 bits) is less than the width
      // of the value being assigned (7 bits from 'source_data').
      process_data = source_data;
    end
  endfunction

  // Drive an output with the function's result to avoid unused signal warnings.
  assign result_out = process_data(data_in);

endmodule
