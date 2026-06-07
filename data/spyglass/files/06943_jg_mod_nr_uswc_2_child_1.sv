module example_wait_2 (
  input wire start_condition,
  input wire value_in,
  output reg value_out
);

always @(start_condition or value_in) begin
  // The 'wait' construct is not synthesizable.
  // It describes a behavior where 'value_out' is assigned 'value_in'
  // only when 'start_condition' is true, and it holds its value
  // otherwise. This behavior corresponds to a level-sensitive latch.
  if (start_condition) begin
    value_out = value_in;
  end
  // When start_condition is false, value_out retains its previous value,
  // which infers a latch. This preserves the functional behavior of the
  // original 'wait' statement, which effectively pauses the assignment
  // until the condition is met.
end

endmodule
