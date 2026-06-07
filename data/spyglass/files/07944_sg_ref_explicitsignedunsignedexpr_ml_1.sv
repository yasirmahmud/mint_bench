module explicit_signed_unsigned_ex1 (input [3:0] data_in, output [7:0] data_out);
 wire [4:0] temp_signed;
 assign temp_signed = {data_in[3], data_in};
 assign data_out = {4'b0, data_in};
 endmodule
