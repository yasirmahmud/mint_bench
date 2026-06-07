module HangingInst_ML_ex1;
 wire inst_i_wire;
 wire inst_o_wire;

 // To resolve W287a, connect input 'i' of instance 'u_inst' to a signal.
 // Since no specific behavior is described for this signal, we can connect it to a constant.
 assign inst_i_wire = 1'b0;

 sub_ex1 u_inst (
  .i (inst_i_wire),
  .o (inst_o_wire) // To resolve W287b, connect output 'o' of instance 'u_inst' to a signal.
 );
 endmodule
