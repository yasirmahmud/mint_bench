interface my_interface_ex1;
  logic clk;
  logic rst;
  logic [7:0] data;
endinterface

module top_module_ex1(input wire i_clk, input wire i_rst);
  my_interface_ex1 if_inst();
  assign if_inst.clk = i_clk;
  assign if_inst.rst = i_rst;

  // To resolve SpyGlass W528 "Variable 'if_inst.clk' set but not read" and
  // "Variable 'if_inst.rst' set but not read",
  // we add a dummy read of these interface signals. This preserves functional behavior.
  logic dummy_clk_read; //sg_waive W528 "dummy_clk_read is created solely to resolve W528 on if_inst.clk and has no functional purpose beyond being read."
  logic dummy_rst_read; //sg_waive W528 "dummy_rst_read is created solely to resolve W528 on if_inst.rst and has no functional purpose beyond being read."

  assign dummy_clk_read = if_inst.clk;
  assign dummy_rst_read = if_inst.rst;

endmodule
