module curve_stx_ve_605_20260110_121033_attempt3 ();

  // Declare a parameter with an initial value
  parameter MY_CONSTANT = 10;

  // The illegal attempt to reassign the parameter is removed to resolve the FATAL violation.
  // Parameters cannot be reassigned after declaration.

  // Dummy output to ensure MY_CONSTANT is used and avoid unused signal warnings
  reg [7:0] output_reg;
  always @(*) begin
    output_reg = MY_CONSTANT + 5; 
  end

endmodule
