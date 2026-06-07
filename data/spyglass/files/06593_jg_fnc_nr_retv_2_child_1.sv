module test_fnc_nr_retv_2;

  function [7:0] get_extended_value;
    input [0:0] flag_in;
    begin
      // Fix W416: Return type is 8 bits, ensure assignment is also 8 bits by zero-extending the 1-bit value.
      get_extended_value = {7'b0, flag_in};
    end
  endfunction

  wire [7:0] result;
  assign result = get_extended_value(1'b1);

  // Fix W528: Use the 'result' wire to prevent the "set but not read" warning.
  initial begin
    $display("Result from get_extended_value: %h", result);
  end

endmodule
