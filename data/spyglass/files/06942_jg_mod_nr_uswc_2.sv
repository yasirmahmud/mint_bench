module example_wait_2 (
  input wire start_condition,
  input wire value_in,
  output reg value_out
);

always @(start_condition or value_in) begin
  wait (start_condition) value_out = value_in;
end

endmodule
