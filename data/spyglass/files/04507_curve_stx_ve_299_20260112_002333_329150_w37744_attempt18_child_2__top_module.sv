module top_module (
  input wire clk
);
  sub_module #(.P({1'b0, 1'b1})) inst_sub1 (.dummy_input(clk));
  sub_module #(.P({1'b1, 1'b0})) inst_sub2 (.dummy_input(clk));
endmodule
