module VariableIndex_ML_ex2 (
    input [1:0] idx,
    input val,
    output [7:0] my_array_out [0:3]
);

  reg [7:0] my_array [0:3]; // Internal storage for the array

  // Original functional behavior: array element is updated based on idx and val
  always @(*) begin
    my_array[idx] = val;
  end

  // Expose the internal array to resolve the "set but not read" violation (W528)
  // This makes the array's state observable from outside the module.
  assign my_array_out = my_array;

endmodule
