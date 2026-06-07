module top_module_ex2;
  wire [7:0] my_wire;
  assign my_wire = 8'b0;
  sub_module_ex2 u_sub_ex2 (.in_port(my_wire));
endmodule
