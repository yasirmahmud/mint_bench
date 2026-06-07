module curve_wrn_44_20260111_053310_attempt1 (
    input wire [7:0] in_a,
    output wire [7:0] out_b
);

  // Define a function
  function automatic [7:0] my_calculate_func;
    input [7:0] val_in;
    begin
      // WRN_44: This non-blocking assignment inside a function triggers the violation.
      // The IEEE Verilog standard does not support non-blocking assignments within functions.
      my_calculate_func <= val_in + 1;
    end
  endfunction

  // Use the function to drive an output
  assign out_b = my_calculate_func(in_a);

endmodule
