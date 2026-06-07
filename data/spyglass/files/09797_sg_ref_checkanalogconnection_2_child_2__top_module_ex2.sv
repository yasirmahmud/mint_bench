module top_module_ex2 ();
  wire analog_net;
  ANA_MACRO_ex2 i_ana (.PO(analog_net));
  DIGITAL_CELL_ex2 i_dig (.A(analog_net));
endmodule
