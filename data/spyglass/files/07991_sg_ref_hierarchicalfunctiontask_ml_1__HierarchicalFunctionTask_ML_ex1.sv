module HierarchicalFunctionTask_ML_ex1;
 sub_module sub_inst();
 reg [7:0] data;
 initial begin data = sub_inst.my_func(5);
 end endmodule
