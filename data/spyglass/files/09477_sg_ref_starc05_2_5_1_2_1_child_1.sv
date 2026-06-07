module tristate_logic_ex1 (input in1, input in2, input data_in, output data_out);
 assign data_out = (in1 & in2) ? data_in : 'bz;
 endmodule
