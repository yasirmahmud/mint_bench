module curve_wrn_44_20260111_053310_attempt4 ();

  // WRN_44: Non-blocking assignment statement in a function.
  // The IEEE 1364-2001/2005 Verilog standards do not support this.
  function automatic [7:0] calculate_and_assign;
    input [7:0] input_data;
    reg [7:0] temp_result; // Local variable in the function

    begin
      // This non-blocking assignment (<=) to a local 'reg' variable
      // inside the function definition body will trigger WRN_44.
      temp_result <= input_data + 1; // This line triggers WRN_44
      
      // The function's return value is then assigned blocking-wise.
      calculate_and_assign = temp_result;
    end
  endfunction

endmodule
