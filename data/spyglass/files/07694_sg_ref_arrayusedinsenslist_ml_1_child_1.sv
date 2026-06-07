module ArrayUsedInSensList_ex1 (
  output reg out_reg
);
  reg [7:0] my_array [0:3];

  // Fix for SpyGlass violation: Variable 'my_array' read but never set.
  // Initialize 'my_array' in an initial block to ensure it has defined values,
  // preventing X-propagation and resolving the 'never set' error.
  initial begin
    my_array[0] = 8'd1;
    my_array[1] = 8'd2;
    my_array[2] = 8'd3;
    my_array[3] = 8'd4;
  end

  // Fix for SpyGlass violation: ArrayUsedInSensList-ML.
  // Replace 'always @(my_array)' with 'always_comb'.
  // 'always_comb' automatically infers all signals read within its block
  // (like my_array[0][0]) into its sensitivity list, which is the correct
  // and modern SystemVerilog practice for combinational logic.
  always_comb begin
    out_reg = my_array[0][0];
  end

  // Fix for SpyGlass violation: Variable 'out_reg' set but not read.
  // Declaring 'out_reg' as an output port ensures its value is driven
  // out of the module, making it 'read' by the external environment.

endmodule
