module test_fnc_nr_retv_1;

  function [1:0] get_truncated_value;
    input [7:0] data_in;
    begin
      // Return type is 2 bits, but assigning an 8-bit value
      get_truncated_value = data_in;
    end
  endfunction

  wire [1:0] result;
  assign result = get_truncated_value(8'hAB);

endmodule
