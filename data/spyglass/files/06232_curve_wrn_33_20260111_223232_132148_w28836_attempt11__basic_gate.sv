// Child module definition
module basic_gate (
  input wire in_1,
  input wire in_2,
  output wire out_val
);
  assign out_val = in_1 ^ in_2; // Simple XOR gate
endmodule
