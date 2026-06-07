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

    // Declare a local variable to store the function's return value.
    // This resolves WRN_1455 by assigning the non-void return value.
    // Changed 'integer func_result;' to 'reg [31:0] func_result;' to resolve STX_VE_481 and STX_VE_606.
    reg [31:0] func_result;

    // Assign the return value of 'my_func' to 'func_result'.
    // 'data_in' (8-bit) will be implicitly zero-extended to match 'arg_val' (integer/32-bit),
    // thereby resolving the STARC05-2.1.3.1 width mismatch.
    func_result = my_func(data_in);
  end

endmodule
