module enum_2state_example_2 (
  output operation_t op_out
);
  typedef enum bit [1:0] {
    OP_ADD = 2'b00,
    OP_SUB = 2'b01,
    OP_MUL = 2'b10
  } operation_t;

  operation_t current_op;

  always_comb begin
    current_op = OP_ADD;
  end

  // SpyGlass W528: Variable 'current_op' set but not read.
  // Resolved by driving an output port with 'current_op'.
  assign op_out = current_op;
endmodule
