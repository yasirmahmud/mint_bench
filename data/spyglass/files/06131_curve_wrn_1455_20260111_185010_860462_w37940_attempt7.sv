module curve_wrn_1455_20260111_185010_860462_w37940_attempt7 (
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // Define a function that returns an integer value (non-void return type)
  function integer my_func (input integer arg_val);
    begin
      my_func = arg_val + 1;
    end
  endfunction

  // Using an always @(*) block to avoid SYNTH_5143 (initial block ignored for synthesis)
  always @(*) begin
    // Dummy assignment to keep output port 'data_out' used and prevent latches
    data_out = data_in; 

    // WRN_1455: This line triggers the violation.
    // 'my_func' has a non-void return type (integer), but its return value
    // is not assigned to a variable, used in an expression, or passed as
    // an argument to another function. This is an "invalid void function call".
    my_func(data_in[7:0]);
  end

endmodule
