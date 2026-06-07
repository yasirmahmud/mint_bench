module curve_synth_5290_20260112_012517_094977_w37744_attempt19 (
  input wire [7:0] in_data,
  output reg [7:0] out_data
);

  // Declare a real function. Verilog-2001 allows functions to return real types.
  // The function declaration itself is often treated as synthesizable for simulation
  // purposes, but the return type 'real' cannot be mapped to physical hardware signals.
  function real calculate_scaled_value;
    input [7:0] value_in;
    begin
      // Performing an operation resulting in a real number (integer * real literal).
      // The result of this function is a 'real' value.
      calculate_scaled_value = value_in * 1.5; 
    end
  endfunction

  // SYNTH_5290 violation:
  // The function 'calculate_scaled_value' returns a 'real' value.
  // Assigning this 'real' return value to a synthesizable bit-vector 'out_data'
  // (declared as 'reg [7:0]') is not synthesizable. Synthesis tools cannot convert
  // a real number into discrete hardware bits for direct assignment.
  always @(*) begin
    out_data = calculate_scaled_value(in_data);
  end

endmodule
