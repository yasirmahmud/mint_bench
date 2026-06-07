module tristate_logic_ex1 (input in1, input in2, input data_in, output data_out);
 wire enable_sig;
 assign enable_sig = in1 & in2;
 bufif1 (data_out, data_in, enable_sig);
 endmodule
