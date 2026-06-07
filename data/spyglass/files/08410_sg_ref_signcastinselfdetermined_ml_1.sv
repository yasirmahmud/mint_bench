module SignCastInSelfDetermined_ex1;
 reg [7:0] data_in;
 wire result_wire;
 assign result_wire = $signed(data_in);
 endmodule
