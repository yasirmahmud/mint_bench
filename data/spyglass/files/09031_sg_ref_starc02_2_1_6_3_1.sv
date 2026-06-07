module star_c02_2_1_6_3_ex1 (input wire [2:0] idx, output reg [7:0] out_val);
 reg [7:0] data_array [7:0];
 always @(*) begin out_val = data_array[idx + 1];
 end endmodule
