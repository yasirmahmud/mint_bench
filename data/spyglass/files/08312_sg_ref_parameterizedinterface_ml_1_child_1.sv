interface my_interface #(parameter WIDTH = 8);
  logic [WIDTH-1:0] data;
endinterface

module top_module_ex1;
  my_interface #(16) if_inst;
endmodule
