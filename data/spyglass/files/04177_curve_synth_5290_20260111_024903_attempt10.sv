module curve_synth_5290_20260111_024903_attempt10 (
  input wire enable_op,
  output reg [7:0] data_out
);

  // Declare a real parameter. While the declaration itself might be tolerated,
  // its subsequent use in synthesizable logic is problematic.
  parameter real INITIAL_VALUE = 50.5;

  // Declare a real variable. In Verilog-2001, 'real' is implicitly a reg type.
  // This type is not synthesizable.
  real internal_real_value;

  always @(*) begin // Combinational block
    if (enable_op) begin
      // Assigning a real parameter to a real variable.
      // This operation involves 'real' types and cannot be synthesized.
      internal_real_value = INITIAL_VALUE;
    end else begin
      internal_real_value = 0.0; // Another assignment to a real variable.
    end
    
    // Attempting to assign a real type directly to an integer/bit-vector type.
    // Verilog-2001 does not provide a synthesizable mechanism for direct conversion
    // of 'real' values to integer hardware representations.
    // This implicit conversion is a direct "Usage of 'Real' is not synthesizable".
    data_out = internal_real_value; // SYNTH_5290 violation expected here.
  end

endmodule
