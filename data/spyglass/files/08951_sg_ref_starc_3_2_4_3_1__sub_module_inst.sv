module sub_module_inst(input in, output out);
 parameter PARAM_VAL = 5;
 assign out = in & PARAM_VAL;
 endmodule
