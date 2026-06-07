module stx_ve_505_example_12 (
  input wire in_a,
  output wire out_b
);

  // Define a function, which is a design element.
  function automatic [0:0] my_function (input [0:0] data_in);
    begin
      // STX_VE_505 violation: `end_keywords is placed inside a design element (a function).
      `end_keywords
      my_function = data_in;
    end
  endfunction

  // Assign the output using the function call to ensure all ports are used.
  assign out_b = my_function(in_a);

endmodule
