module test_fnc_nr_retv_2;

  function [7:0] get_extended_value;
    input [0:0] flag_in;
    begin
      // Return type is 8 bits, but assigning a 1-bit value
      get_extended_value = flag_in;
    end
  endfunction

  wire [7:0] result;
  assign result = get_extended_value(1'b1);

endmodule
