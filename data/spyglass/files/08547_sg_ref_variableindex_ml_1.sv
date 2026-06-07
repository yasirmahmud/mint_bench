module variable_index_ml_ex1(input [1:0] index_in, output reg [7:0] out_data);
 reg [7:0] data_mem [0:3];
 always @(*) begin data_mem[index_in] = 8'hAA;
 out_data = data_mem[0];
 end endmodule
