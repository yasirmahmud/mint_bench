module top_module_ex1;
  wire [7:0] my_wire;
  assign my_wire = 8'hFF;
  // Fix W110: Explicitly truncate my_wire to match the width of in_port
  sub_module u_sub ( .in_port(my_wire[3:0]) );
endmodule
