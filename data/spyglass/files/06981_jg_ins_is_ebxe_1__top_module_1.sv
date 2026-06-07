module top_module_1 (
  input wire clk,
  input wire rst,
  input wire in_a,
  output wire out_b
);
  sub_module u_sub (
    .a(in_a),
    .b(out_b)
  );
endmodule
