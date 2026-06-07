module right_shift_trunc_ex2 (input [15:0] data_in, input [3:0] shift_val, output reg [7:0] data_out);
 always @(*) begin 
  data_out = (data_in >> shift_val)[7:0];
 end 
endmodule
