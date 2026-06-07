module delayed_assign_wire (
  input wire clk,
  input wire rst_n,
  input wire in_data,
  output wire out_data
);

  assign #5 out_data = in_data;

endmodule
