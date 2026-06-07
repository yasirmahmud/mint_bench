module MultiAssignConcat_ML_ex1 (input [3:0] data_in, output [3:0] data_out);
 wire [1:0] my_sig;
 assign {my_sig[1], my_sig[0], my_sig[1], my_sig[0]} = data_in;
 assign data_out = data_in;
 endmodule
