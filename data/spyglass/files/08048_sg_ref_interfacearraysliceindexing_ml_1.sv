interface my_if;
 logic [7:0] data_bus[3:0];
 endinterface module InterfaceArraySliceIndexing_ML_ex1;
 my_if if_inst();
 logic [7:0] local_data_slice[1:0];
 initial begin local_data_slice = if_inst.data_bus[0 +: 2];
 end endmodule
