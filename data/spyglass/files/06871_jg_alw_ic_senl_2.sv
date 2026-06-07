module incomplete_rhs_senl (
  input wire a,
  input wire b,
  output reg c
);

always @(a) begin // b is missing from sensitivity list
  c = a & b; // b is used on the right-hand side of an assignment
end

endmodule
